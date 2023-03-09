class City{
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  static List<City> citiesList = [
    City(
        isSelected: false,
        city: 'Hyderabad',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Itanagar',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Dispur',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Patna',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Raipur',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Panaji',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Gandhinagar',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Chandigarh',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Shimla',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Jammu',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Ranchi',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Bengaluru',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Thiruvananthapuram',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Bhopal',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Mumbai',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Imphal',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Shillong',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Aizawl',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Kohima',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Bhubaneshwar',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Chandigarh',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Jaipur',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Gangtok',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Chennai',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Agartala',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Lucknow',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Dehradun',
        country: 'India',
        isDefault: false),
    City(
        isSelected: false,
        city: 'Kolkata',
        country: 'India',
        isDefault: true),
    City(
        isSelected: false,
        city: 'Amaravati',
        country: 'India',
        isDefault: false),
  ];

  static List<City> getSelectedCities(){
    List<City> selectedCities = City.citiesList;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
}