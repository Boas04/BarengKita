import 'package:flutter/material.dart';
import '../models/resource.dart';
import '../theme/app_theme.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  ResourceCategory? _selectedCategory;

  List<Resource> get _filteredResources {
    if (_selectedCategory == null) return resources;
    return resources.where((r) => r.category == _selectedCategory).toList();
  }

  static const _categories = [
    (label: 'Semua', value: null),
    (label: 'Memahami', value: ResourceCategory.understanding),
    (label: 'Hak Hukum', value: ResourceCategory.legalRights),
    (label: 'Perawatan Diri', value: ResourceCategory.selfCare),
    (label: 'Mendukung', value: ResourceCategory.supportingOthers),
  ];

  Color _categoryColor(ResourceCategory? category) {
    switch (category) {
      case ResourceCategory.understanding:
        return AppTheme.primaryPurple;
      case ResourceCategory.legalRights:
        return AppTheme.calmBlue;
      case ResourceCategory.selfCare:
        return AppTheme.safeGreen;
      case ResourceCategory.supportingOthers:
        return AppTheme.softPink;
      default:
        return Colors.grey;
    }
  }

  IconData _categoryIcon(ResourceCategory? category) {
    switch (category) {
      case ResourceCategory.understanding:
        return Icons.info_outline;
      case ResourceCategory.legalRights:
        return Icons.gavel;
      case ResourceCategory.selfCare:
        return Icons.self_improvement;
      case ResourceCategory.supportingOthers:
        return Icons.favorite_outline;
      default:
        return Icons.article;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: AppBar(
        title: const Text('Sumber Daya'),
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: _filteredResources.isEmpty
                ? const Center(child: Text('Tidak ada artikel tersedia'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredResources.length,
                    itemBuilder: (context, index) {
                      return _ResourceCard(
                        resource: _filteredResources[index],
                        categoryColor:
                            _categoryColor(_filteredResources[index].category),
                        categoryIcon:
                            _categoryIcon(_filteredResources[index].category),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: _categories.map((cat) {
            final isSelected = _selectedCategory == cat.value;
            final color = _categoryColor(cat.value);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(cat.label),
                selected: isSelected,
                onSelected: (_) =>
                    setState(() => _selectedCategory = cat.value),
                selectedColor: color.withOpacity(0.18),
                checkmarkColor: color,
                labelStyle: TextStyle(
                  color: isSelected ? color : Colors.grey[700],
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final Resource resource;
  final Color categoryColor;
  final IconData categoryIcon;

  const _ResourceCard({
    required this.resource,
    required this.categoryColor,
    required this.categoryIcon,
  });

  void _openDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _ResourceDetailScreen(
          resource: resource,
          categoryColor: categoryColor,
          categoryIcon: categoryIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: () => _openDetail(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: categoryColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(categoryIcon, color: categoryColor, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        resource.categoryLabel,
                        style: TextStyle(
                          fontSize: 11,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      resource.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      resource.summary,
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[600], height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResourceDetailScreen extends StatelessWidget {
  final Resource resource;
  final Color categoryColor;
  final IconData categoryIcon;

  const _ResourceDetailScreen({
    required this.resource,
    required this.categoryColor,
    required this.categoryIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: AppBar(
        title: Text(resource.categoryLabel),
        backgroundColor: categoryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(categoryIcon, color: categoryColor, size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    resource.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                resource.summary,
                style: TextStyle(
                    fontSize: 14,
                    color: categoryColor,
                    fontWeight: FontWeight.w500,
                    height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            _buildFormattedContent(resource.content),
            if (resource.sourceUrl != null) ...[
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.link, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Sumber: ${resource.sourceUrl}',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedContent(String content) {
    final lines = content.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) {
        if (line.startsWith('**') && line.endsWith('**')) {
          return Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 6),
            child: Text(
              line.replaceAll('**', ''),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(
            line,
            style: const TextStyle(fontSize: 14, height: 1.65),
          ),
        );
      }).toList(),
    );
  }
}
