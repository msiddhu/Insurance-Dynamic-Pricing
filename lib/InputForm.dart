import 'package:dynamic_pricing/PricePage.dart';
import 'package:dynamic_pricing/TripData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'InsuranceCost.dart';
import 'package:intl/intl.dart';

import 'Request.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// Define a custom Form widget.
class InputForm extends StatefulWidget {
  const InputForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<InputForm> {
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String origin = 'Bangalore';
  String destination = 'New Delhi';
  String airline = 'AirAsia India';
  String passengerCount = '1';
  String hour ='00';
  DateTime bookingDateTime = DateTime.now().subtract(Duration(
    hours: DateTime.now().hour,
    minutes: DateTime.now().minute,
    seconds: DateTime.now().second,
    milliseconds: DateTime.now().millisecond,
    microseconds: DateTime.now().microsecond,
  ));
  DateTime tripDateTime= DateTime.now();
  var citiesMapping= {'New Delhi': ['DEL'], 'Mumbai': ['BOM', 'Maharashtra'], 'Chennai': ['MAA', 'Tamil Nadu'], 'Bangalore': ['BLR', 'Karnataka'], 'Vasco da Gama': ['GOI', 'Goa'], 'Kolkata': ['CCU', 'West Bengal'], 'Kochi': ['COK'], 'Hyderabad': ['HYD', 'Telangana'], 'Thiruvananthapuram': ['TRV'], 'Ahmedabad': ['AMD', 'Gujarat'], 'Jaipur': ['JAI', 'Rajasthan'], 'Pune': ['PNQ', 'Maharashtra'], 'Amritsar': ['ATQ', 'Punjab'], 'Vadodara': [ 'BDQ'], 'Mangalore': ['IXE', 'Karnataka'], 'Varanasi': ['VNS'], 'Bhubaneswar': ['BBI'], 'Guwahati': ['GAU'], 'Visakhapatnam': ['VTZ'], 'Calicut': [ 'CCJ'], 'Coimbatore': ['CJB'], 'Jodhpur': ['JDH', 'Rajasthan'], 'Madurai': ['IXM', 'Tamil Nadu'], 'Lucknow': ['LKO'], 'Patna': ['PAT'], 'Chandigarh': ['IXC', 'Chandigarh'], 'Indore': ['IDR', 'Madhya Pradesh'], 'Port Blair': ['IXZ'], 'Siliguri': ['IXB', 'West Bengal'], 'Udaipur': ['UDR', 'Rajasthan'], 'Nagpur': ['NAG', 'Maharashtra'], 'Leh': ['IXL', 'Ladakh'], 'Srinagar': ['SXR', 'Jammu and Kashmir'], 'Agartala': [ 'IXA'], 'Aurangabad': ['IXU', 'Maharashtra'], 'Bhuj': ['BHJ'], 'Gannavaram': ['VGA', 'Andhra Pradesh'], 'Ranchi': ['IXR', 'Jharkhand'], 'Raipur': ['RPR', 'Chhattisgarh'], 'Bhopal': ['BHO', 'Madhya Pradesh'], 'Imphal': ['IMF'], 'Jammu': ['IXJ', 'Jammu and Kashmir'], 'Jorhat': [ 'JRH'], 'Rajkot': ['RAJ'], 'Agatti': ['AGX'], 'Agra': [ 'AGR'], 'Dibrugarh': ['DIB', 'Assam'], 'Gondia': ['GDB', 'Maharashtra'], 'Nasik': ['ISK', 'Maharashtra'], 'Bhuntar': ['KUU', 'Himachal Pradesh'], 'Puttaparthi': ['PUT', 'Andhra Pradesh'], 'Darbhanga': ['DBR'], 'Jamnagar': ['JGA', 'Gujarat'], 'Madhurapudi': ['RJA'], 'Silchar': ['IXS', 'Assam'], 'Allahabad': [ 'IXD'], 'Kannur': ['CNN', 'Kerala'], 'Khajuraho': ['HJR', 'Madhya Pradesh'], 'Jamshedpur': ['IXW', 'Jharkhand'], 'Jubbarhatti': [ 'SLV'], 'Tirupati': ['TIR'], 'Belgaum': ['IXG', 'Karnataka'], 'Bhavnagar': ['BHU'], 'Dehradun (Jauligrant)': ['DED'], 'Porbandar': ['PBD', 'Gujarat'], 'Shillong': ['SHL'], 'Tiruchirappalli': ['TRZ', 'Tamil Nadu'], 'Aizawl (Lengpui)': [ 'AJL'], 'Durgapur': ['RDP', 'West Bengal'], 'Gaggal': ['DHM', 'Himachal Pradesh'], 'Hubli': ['HBX'], 'Kanpur': ['KNU'], 'Pathankot': ['IXP'], 'Puducherry (Pondicherry)': ['PNY'], 'Bellary': ['BEP', 'Karnataka'], 'Bidar': ['IXX', 'Karnataka'], 'Kailashahar': ['IXH', 'Tripura'], 'Keshod': ['IXK'], 'Kota': ['KTU', 'Rajasthan'], 'Rewa': ['REW', 'Madhya Pradesh'], 'Rourkela': ['RRK'], 'Diu': ['DIU', 'Dadra and Nagar Haveli and Daman and Diu'], 'Balurghat': ['RGH', 'West Bengal'], 'Khowai': ['IXN'], 'Malda': ['LDA', 'West Bengal'], 'Manik Bhandar': ['IXQ'], 'Mysore': ['MYQ'], 'Thanjavur': ['TJV'], 'Dimapur': ['DMU'], 'Gwalior': ['GWL', 'Madhya Pradesh'], 'Lilabari': ['IXI'], 'Ajmer (Kishangarh)': ['KQH', 'Rajasthan'], 'Bilaspur': ['PAB', 'Chhattisgarh'], 'Gorakhpur': [ 'GOP'], 'Kadapa': ['CDP'], 'Kakadi': ['SAG', 'Maharashtra'], 'Kandla': [ 'IXY'], 'Latur': ['LTU', 'Maharashtra'], 'Nanded': ['NDC'], 'Orvakal': ['KJB'], 'Pantnagar': ['PGH'], 'Akola': ['AKD', 'Maharashtra'], 'Bareilly': ['BEK'], 'Bikaner': ['BKB', 'Rajasthan'], 'Daman': ['NMB'], 'Hollongi': ['HGI'], 'IAF Camp': [ 'CBD'], 'Kushinagar': ['KBK'], 'Muzaffarpur': [ 'MZU'], 'Salem': ['SXV', 'Tamil Nadu'], 'Solapur': ['SSE', 'Maharashtra'], 'Ziro': ['ZER', 'Arunachal Pradesh'], 'Adampur': ['AIP', 'Punjab'], 'Jagdalpur': ['JGB', 'Chhattisgarh'], 'Vagaikulam': ['TCR', 'Tamil Nadu'], 'Cooch Behar': ['COH', 'West Bengal'], 'Daporijo': [ 'DEP'], 'Jeypore': ['PYB'], 'Neyveli': ['NVY'], 'Osmanabad': ['OMN', 'Maharashtra'], 'Pakyong': ['PYG', 'Sikkim'], 'Pasighat': ['IXT', 'Arunachal Pradesh'], 'Rajouri': ['RJI', 'Jammu and Kashmir'], 'Ramagundam': ['RMD', 'Telangana'], 'Rupsi': ['RUP'], 'Tezu': ['TEI', 'Arunachal Pradesh'], 'Toranagallu': ['VDY', 'Karnataka'], 'Warangal': ['WGC', 'Telangana']};
  var citiesList=['New Delhi', 'Mumbai', 'Chennai', 'Bangalore', 'Vasco da Gama', 'Kolkata', 'Kochi', 'Hyderabad', 'Thiruvananthapuram', 'Ahmedabad', 'Jaipur', 'Pune', 'Amritsar', 'Vadodara', 'Mangalore', 'Varanasi', 'Bhubaneswar', 'Guwahati', 'Visakhapatnam', 'Calicut', 'Coimbatore', 'Jodhpur', 'Madurai', 'Lucknow', 'Patna', 'Chandigarh', 'Indore', 'Port Blair', 'Siliguri', 'Udaipur', 'Nagpur', 'Leh', 'Srinagar', 'Agartala', 'Aurangabad', 'Bhuj', 'Gannavaram', 'Ranchi', 'Raipur', 'Bhopal', 'Imphal', 'Jammu', 'Jorhat', 'Rajkot', 'Agatti', 'Agra', 'Dibrugarh', 'Gondia', 'Nasik', 'Bhuntar', 'Puttaparthi', 'Darbhanga', 'Jamnagar', 'Madhurapudi', 'Silchar', 'Allahabad', 'Kannur', 'Khajuraho', 'Jamshedpur', 'Jubbarhatti', 'Tirupati', 'Belgaum', 'Bhavnagar', 'Dehradun (Jauligrant)', 'Porbandar', 'Shillong', 'Tiruchirappalli', 'Aizawl (Lengpui)', 'Durgapur', 'Gaggal', 'Hubli', 'Kanpur', 'Pathankot', 'Puducherry (Pondicherry)', 'Bellary', 'Bidar', 'Kailashahar', 'Keshod', 'Kota', 'Rewa', 'Rourkela', 'Diu', 'Balurghat', 'Khowai', 'Malda', 'Manik Bhandar', 'Mysore', 'Thanjavur', 'Dimapur', 'Gwalior', 'Lilabari', 'Ajmer (Kishangarh)', 'Bilaspur', 'Gorakhpur', 'Kadapa', 'Kakadi', 'Kandla', 'Latur', 'Nanded', 'Orvakal', 'Pantnagar', 'Akola', 'Bareilly', 'Bikaner', 'Daman', 'Hollongi', 'IAF Camp', 'Kushinagar', 'Muzaffarpur', 'Salem', 'Solapur', 'Ziro', 'Adampur', 'Jagdalpur', 'Vagaikulam', 'Cooch Behar', 'Daporijo', 'Jeypore', 'Neyveli', 'Osmanabad', 'Pakyong', 'Pasighat', 'Rajouri', 'Ramagundam', 'Rupsi', 'Tezu', 'Toranagallu', 'Warangal'];
  var airportsList = ['AGR', 'AGX', 'AIP', 'AJL', 'AMD', 'ATQ', 'BBI', 'BDQ', 'BEK', 'BHJ', 'BHO', 'BHU', 'BKB', 'BLR', 'BOM', 'CCJ', 'CCU', 'CDP', 'CJB', 'CNN', 'COK', 'DBR', 'DED', 'DEL', 'DHM', 'DIB', 'DIU', 'DMU', 'GAU', 'GAY', 'GBI', 'GOI', 'GOP', 'GWL', 'HBX', 'HJR', 'HYD', 'IDR', 'IMF', 'ISK', 'IXA', 'IXB', 'IXC', 'IXD', 'IXE', 'IXG', 'IXI', 'IXJ', 'IXL', 'IXM', 'IXP', 'IXR', 'IXS', 'IXT', 'IXU', 'IXX', 'IXY', 'IXZ', 'JAI', 'JDH', 'JGA', 'JGB', 'JLG', 'JLR', 'JRG', 'JRH', 'JSA', 'KBK', 'KJB', 'KLH', 'KNU', 'KQH', 'KUU', 'LKO', 'LUH', 'MAA', 'MYQ', 'NAG', 'NDC', 'PAB', 'PAT', 'PBD', 'PGH', 'PNQ', 'PYG', 'RAJ', 'RDP', 'RJA', 'RPR', 'RUP', 'SAG', 'SDW', 'SHL', 'STV', 'SXR', 'SXV', 'TCR', 'TEI', 'TEZ', 'TIR', 'TRV', 'TRZ', 'UDR', 'VDX', 'VDY', 'VGA', 'VNS', 'VTZ'];
  var airlinesList = ['Air India', 'Air India Express', 'AirAsia India', 'Alliance Air', 'FlyBig', 'Go First', 'IndiGo', 'Originair', 'SpiceXpress', 'Star Air', 'TruJet', 'Vistara'];
  var passengerCountList=['1','2','3','4','5','6','7'];
  var hoursList=['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: tripDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (picked != null && picked != tripDateTime) {
      setState(() {
        tripDateTime = picked;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: FractionallySizedBox(
          alignment: Alignment.center,
          widthFactor: 0.3,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
            Container(
            padding:const EdgeInsets.all(5.0),
            child: Column(
              children: [
                Text("Flying from",style: TextStyle(fontWeight: FontWeight.bold),),
                DropdownButton(

                  value: origin,

                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: citiesList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      origin = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
                Container(
                  padding:const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text("Flying to",style: TextStyle(fontWeight: FontWeight.bold),),
                      DropdownButton(
                        value: destination,
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: citiesList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            destination = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text("Airline",style: TextStyle(fontWeight: FontWeight.bold),),
                      DropdownButton(

                        value: airline,

                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: airlinesList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            airline = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text("Number of passengers",style: TextStyle(fontWeight: FontWeight.bold),),
                      DropdownButton(

                        value: passengerCount,

                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: passengerCountList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            passengerCount = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Container(
                  padding:const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text("Time of departure",style: TextStyle(fontWeight: FontWeight.bold),),
                      DropdownButton(

                        value: hour,

                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: hoursList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            hour = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date'),
                    ),
                    const SizedBox(height: 20.0,),
                    Text("Travel Date: "+"${tripDateTime.toLocal()}".split(' ')[0]),
                  ],
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() && origin !=destination) {
                      tripDateTime=tripDateTime.add(Duration(hours: int.parse(hour)));
                      Map<String,dynamic> tripDataJson={
                        'origin': citiesMapping[origin]![0],
                        'destination': citiesMapping[destination]![0],
                        'airline': airline,
                        'passenger_count': int.parse(passengerCount),
                        'booking_date_time': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(bookingDateTime),
                        'trip_date_time': DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(tripDateTime),
                      };
                      TripData tripData=TripData(origin, destination, airline, int.parse(passengerCount), bookingDateTime, tripDateTime);
                      InsuranceCost insuranceCost=await makePostRequest(tripDataJson);
                      if(!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            PricePage(insuranceCost: insuranceCost,tripData: tripData)),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
                // Add TextFormFields and ElevatedButton here.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createDropDown(String title,String value, List<String> items){
    return Container(
      padding:const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
          DropdownButton(

            value: value,

            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                value = newValue!;
              });
            },
          ),
        ],
      ),
    );

  }
}