class FermentationProfile {
  final String fruitId;
  final int minDays;
  final int maxDays;

  const FermentationProfile({
    required this.fruitId,
    required this.minDays,
    required this.maxDays,
  });
}

// Planning windows for sound fruit mash inoculated with cultured yeast and
// fermented under controlled conditions. They are not guaranteed finish dates.
const fermentationProfiles = <FermentationProfile>[
  FermentationProfile(fruitId: 'apple', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'pear', minDays: 12, maxDays: 24),
  FermentationProfile(fruitId: 'quince', minDays: 16, maxDays: 30),
  FermentationProfile(fruitId: 'medlar', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'plum', minDays: 9, maxDays: 18),
  FermentationProfile(fruitId: 'apricot', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'peach', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'sweet_cherry', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'sour_cherry', minDays: 8, maxDays: 16),
  FermentationProfile(fruitId: 'sloe', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'cornelian_cherry', minDays: 10, maxDays: 21),
  FermentationProfile(fruitId: 'grape', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'strawberry', minDays: 6, maxDays: 12),
  FermentationProfile(fruitId: 'raspberry', minDays: 6, maxDays: 12),
  FermentationProfile(fruitId: 'blackberry', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'blackcurrant', minDays: 9, maxDays: 18),
  FermentationProfile(fruitId: 'redcurrant', minDays: 9, maxDays: 18),
  FermentationProfile(fruitId: 'gooseberry', minDays: 9, maxDays: 18),
  FermentationProfile(fruitId: 'blueberry', minDays: 8, maxDays: 16),
  FermentationProfile(fruitId: 'elderberry', minDays: 8, maxDays: 16),
  FermentationProfile(fruitId: 'mulberry', minDays: 7, maxDays: 14),
  FermentationProfile(fruitId: 'rosehip', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'rowanberry', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'service_tree', minDays: 14, maxDays: 28),
  FermentationProfile(fruitId: 'fig', minDays: 10, maxDays: 21),
];
