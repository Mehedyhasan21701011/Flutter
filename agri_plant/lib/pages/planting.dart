import 'package:flutter/material.dart';

/// Radish Planting Guide Page
/// Drop this file into your Flutter project (e.g. lib/pages/radish_planting_guide_page.dart)
/// and import it where you need to show the page.

class RadishPlantingGuidePage extends StatelessWidget {
  const RadishPlantingGuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radish Planting Guide'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHero(context),
              const SizedBox(height: 16),
              _buildSectionTitle('Quick Facts'),
              _buildQuickFactsCard(),
              const SizedBox(height: 12),
              _buildSectionTitle('Soil & Site'),
              _buildInfoCard(
                title: 'Best soil & Sun',
                content:
                    'Radishes prefer loose, well-draining soil with lots of organic matter. pH 5.5–6.8. Full sun gives fastest growth, but partial shade is OK in very hot regions.',
              ),
              const SizedBox(height: 12),
              _buildSectionTitle('Planting'),
              _buildPlantingCard(),
              const SizedBox(height: 12),
              _buildSectionTitle('Care'),
              _buildCareCard(),
              const SizedBox(height: 12),
              _buildSectionTitle('Harvest & Storage'),
              _buildHarvestCard(),
              const SizedBox(height: 20),
              _buildSectionTitle('Tips'),
              _buildTipsCard(),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Saved to favorites (example)')),
                  );
                },
                icon: const Icon(Icons.bookmark_border),
                label: const Text('Save Guide'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          'https://images.unsplash.com/photo-1506801310323-534be5e7a1de?auto=format&fit=crop&w=1350&q=80',
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: progress.expectedTotalBytes != null
                    ? progress.cumulativeBytesLoaded /
                        (progress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: const Center(child: Icon(Icons.error_outline)),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildQuickFactsCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _factColumn('Days to harvest', '20–60'),
            _factColumn('Spacing', '2–4 in (thinned)'),
            _factColumn('Depth', '1/2 in'),
            _factColumn('Sun', 'Full sun–partial shade'),
          ],
        ),
      ),
    );
  }

  Widget _factColumn(String heading, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required String content}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantingCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('When to plant',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
              'Plant radish seeds in early spring and again in late summer for a fall crop. In mild climates you can sow through winter. Radishes like cool weather — aim for 50–70°F / 10–21°C.',
            ),
            const SizedBox(height: 12),
            const Text('How to sow',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
              '1. Prepare soil: loosen to 8–12 inches and mix in compost.\n'
              '2. Sow seeds 1/2 inch deep in rows 12 in apart or scatter in wide furrows.\n'
              '3. Thin seedlings to 2–4 inches when they reach 1–2 inches tall to allow roots room to develop.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Watering',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'Keep soil evenly moist. Irregular watering causes radishes to crack or become pithy. Water lightly but frequently in hot weather.'),
            const SizedBox(height: 12),
            const Text('Fertilizer',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'If your soil is rich in compost you may not need additional fertilizer. Avoid high nitrogen feed which encourages leafy growth at the expense of roots.'),
            const SizedBox(height: 12),
            const Text('Pests & Diseases',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'Watch for flea beetles (row covers help), root maggots, and fungal diseases in poorly drained soils. Rotate crops yearly to reduce buildup.'),
          ],
        ),
      ),
    );
  }

  Widget _buildHarvestCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('When to harvest',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'Harvest when roots reach the recommended size (often 1–2 inches for common varieties). Don\'t leave them in the ground too long — they get woody and pithy.'),
            const SizedBox(height: 12),
            const Text('Storing',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
                'Trim tops, refrigerate in a sealed bag — use within 1–2 weeks for best texture.'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Quick tips', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 8),
            Text(
                '• Sow succession crops every 1–2 weeks for a continuous harvest.'),
            SizedBox(height: 6),
            Text(
                '• Interplant with slow-growing crops — radishes mature fast and free up space.'),
            SizedBox(height: 6),
            Text(
                '• If radishes bolt (go to seed) it usually means it got too warm; pull and resow later.'),
            SizedBox(height: 6),
            Text(
                '• For larger roots, choose "long" varieties and loosen deeper soil.'),
          ],
        ),
      ),
    );
  }
}
