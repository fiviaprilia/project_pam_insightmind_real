// lib/src/features/insightmind/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';
import '../../providers/questionnaire_provider.dart';
import 'screening_page.dart';
import 'result_page.dart';
import 'profile_page.dart';
import 'dashboard_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // Palette Warna
  final Color deepDarkBrown = const Color(0xFF2D1B14); 
  final Color primaryBrown = const Color(0xFF634832);  
  final Color accentPink = const Color(0xFFE07A5F);    
  final Color creamHighlight = const Color(0xFFF4F1DE);
  final Color surfaceBrown = const Color(0xFF3D2B24);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final questionnaire = ref.watch(questionnaireProvider);

    if (user == null) {
      return Scaffold(
        backgroundColor: creamHighlight, // Ubah ke cream
        body: Center(child: Text('User tidak ditemukan', style: TextStyle(color: deepDarkBrown))),
      );
    }

    final bool hasCompletedScreening = questionnaire.isComplete;

    return Scaffold(
      // SEKARANG: Background utama menggunakan Cream agar lebih segar
      backgroundColor: creamHighlight, 
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'INSIGHTMIND',
          style: TextStyle(
            color: creamHighlight,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 20,
          ),
        ),
        // AppBar tetap Cokelat Tua untuk kesan Bold
        backgroundColor: deepDarkBrown,
        foregroundColor: creamHighlight,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_outlined, color: accentPink, size: 28),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER BACKGROUND DECORATION (Aksen Cokelat di bagian atas)
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: deepDarkBrown,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // CARD SELAMAT DATANG (Tetap gelap agar kontras dengan background cream)
                  _buildWelcomeCard(user),

                  const SizedBox(height: 32),
                  _buildSectionLabel("CORE ASSESSMENT", deepDarkBrown),
                  const SizedBox(height: 16),

                  _buildActionButton(
                    context: context,
                    title: 'Mulai Screening Baru',
                    subtitle: 'Evaluasi intelligence system anda',
                    icon: Icons.psychology_outlined,
                    color1: accentPink,
                    color2: primaryBrown,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScreeningPage())),
                  ),

                  const SizedBox(height: 40),
                  Center(child: _buildDecorativeDivider()),
                  const SizedBox(height: 32),

                  _buildSectionLabel("SIMULASI DATA", deepDarkBrown),
                  const SizedBox(height: 16),

                  // CONTAINER SIMULASI (Ubah ke cokelat yang lebih soft)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white, // Putih bersih di atas latar cream
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(9, (i) {
                        final answer = questionnaire.answers.values.elementAtOrNull(i) ?? 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: creamHighlight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryBrown.withOpacity(0.1)),
                          ),
                          child: Text(
                            answer.toString(),
                            style: TextStyle(color: primaryBrown, fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 24),

                  hasCompletedScreening
                      ? _buildActionButton(
                          context: context,
                          title: 'Lihat Hasil Analisis',
                          subtitle: 'Data sudah siap diproses',
                          icon: Icons.insights_rounded,
                          color1: const Color(0xFF588157), 
                          color2: const Color(0xFF3A5A40),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ResultPage())),
                        )
                      : _buildDisabledButton('Hasil Belum Tersedia', Icons.lock_clock_outlined),

                  const SizedBox(height: 32),
                  _buildSectionLabel("SISTEM REPORTING", deepDarkBrown),
                  const SizedBox(height: 16),
                  
                  _buildActionButton(
                    context: context,
                    title: 'Buka Dashboard',
                    subtitle: 'Pantau statistik & metrik',
                    icon: Icons.dashboard_customize_outlined,
                    color1: deepDarkBrown,
                    color2: surfaceBrown,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardPage())),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(dynamic user) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: deepDarkBrown,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: accentPink,
            child: Text(
              user.name[0].toUpperCase(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: creamHighlight),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, ${user.name.split(' ').first}!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: creamHighlight),
                ),
                Text(
                  'Siap eksplorasi diri hari ini?',
                  style: TextStyle(color: creamHighlight.withOpacity(0.6), fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label, Color color) {
    return Text(
      label,
      style: TextStyle(
        color: color.withOpacity(0.5),
        fontSize: 12,
        fontWeight: FontWeight.w900,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color1, color2]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: color1.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: creamHighlight, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: creamHighlight, fontWeight: FontWeight.w800, fontSize: 16)),
                  Text(subtitle, style: TextStyle(color: creamHighlight.withOpacity(0.7), fontSize: 12)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: creamHighlight.withOpacity(0.5), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDisabledButton(String text, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 32),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.lock_outline, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  Widget _buildDecorativeDivider() {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: primaryBrown.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}