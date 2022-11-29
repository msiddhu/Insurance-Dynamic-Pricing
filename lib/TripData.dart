class TripData{
  String origin = 'Item 1';
  String destination = 'Item 1';
  String airline = 'Item 1';
  int passengerCount = 1;
  DateTime bookingDateTime = DateTime.now();
  DateTime tripDateTime= DateTime.now();

  TripData(this.origin, this.destination, this.airline, this.passengerCount,
      this.bookingDateTime, this.tripDateTime);
}