import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/app_colors.dart';
import '../../core/app_strings.dart';
import '../../core/app_text_size.dart';
import '../../core/app_spacing.dart';
import '../../core/app_padings.dart';
import '../../view_models/auth_view_model.dart';
import '../userSelectionScreen/user_selection_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.homeBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.homePrimary,
                  size: 24,
                ),
              ),
            ),
            AppSpacing.hL(context),
            Text(
              AppStrings.signupTitle,
              style: GoogleFonts.dmSans(
                fontSize: AppTextSize.headlineLarge(context),
                fontWeight: FontWeight.bold,
                color: AppColors.homeTitleText,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: AppPaddings.hL(
              context,
            ).add(const EdgeInsets.only(top: 20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.signupSubtitle,
                  style: GoogleFonts.dmSans(
                    fontSize: AppTextSize.displayMedium(context),
                    fontWeight: FontWeight.bold,
                    color: AppColors.homePrimary,
                  ),
                ),
                const SizedBox(height: 30),

                _buildInputField(
                  controller: _nameController,
                  label: AppStrings.nameLabel,
                  hint: 'John Doe',
                  icon: Icons.person_outline_rounded,
                ),
                AppSpacing.vM(context),

                _buildInputField(
                  controller: _emailController,
                  label: AppStrings.emailLabel,
                  hint: 'name@example.com',
                  icon: Icons.alternate_email_rounded,
                ),
                AppSpacing.vM(context),

                _buildInputField(
                  controller: _contactController,
                  label: 'Phone Number',
                  hint: '+1 234 567 890',
                  icon: Icons.phone_android_rounded,
                  inputType: TextInputType.phone,
                ),
                AppSpacing.vM(context),

                _buildPasswordField(
                  controller: _passwordController,
                  label: AppStrings.passwordLabel,
                  obscure: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                AppSpacing.vM(context),

                _buildPasswordField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  obscure: _obscureConfirmPassword,
                  onToggle: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                ),

                AppSpacing.vXL(context),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: authViewModel.isLoading
                        ? null
                        : () async {
                            if (_nameController.text.isEmpty ||
                                _emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _confirmPasswordController.text !=
                                    _passwordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please check your inputs'),
                                ),
                              );
                              return;
                            }

                            await authViewModel.signup(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            );

                            if (mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserSelectionScreen(),
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.homePrimary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: authViewModel.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            AppStrings.signupBtn,
                            style: GoogleFonts.dmSans(
                              fontSize: AppTextSize.titleMedium(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'By signing up, you agree to our ',
                        style: GoogleFonts.dmSans(
                          fontSize: AppTextSize.labelSmall(context),
                          color: AppColors.homeSubtitleText,
                        ),
                      ),
                      Text(
                        'Terms & Privacy Policy',
                        style: GoogleFonts.dmSans(
                          fontSize: AppTextSize.labelSmall(context),
                          color: AppColors.homePrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: GoogleFonts.dmSans(
                          fontSize: AppTextSize.titleSmall(context),
                          color: AppColors.homeSubtitleText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppSpacing.hXS(context),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const UserSelectionScreen()),
                        ),
                        child: Text(
                          AppStrings.loginBtn,
                          style: GoogleFonts.dmSans(
                            fontSize: AppTextSize.titleSmall(context),
                            color: AppColors.homePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: AppTextSize.labelMedium(context),
            fontWeight: FontWeight.w600,
            color: AppColors.homeSubtitleText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFE0E4E8)),
          ),
          child: TextField(
            controller: controller,
            keyboardType: inputType,
            style: GoogleFonts.dmSans(
              fontSize: AppTextSize.titleMedium(context),
              fontWeight: FontWeight.w500,
              color: AppColors.homeTitleText,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.dmSans(color: AppColors.homeHintText),
              prefixIcon: Icon(icon, color: AppColors.homePrimary, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: AppTextSize.labelMedium(context),
            fontWeight: FontWeight.w600,
            color: AppColors.homeSubtitleText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F8),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xFFE0E4E8)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: GoogleFonts.dmSans(
              fontSize: AppTextSize.titleMedium(context),
              fontWeight: FontWeight.w500,
              color: AppColors.homeTitleText,
            ),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: GoogleFonts.dmSans(color: AppColors.homeHintText),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.homePrimary,
                size: 20,
              ),
              suffixIcon: GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.homeSubtitleText,
                  size: 20,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
