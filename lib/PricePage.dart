import 'package:dynamic_pricing/InsuranceCost.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format


import 'TripData.dart';

class PricePage extends StatelessWidget {
  const PricePage({super.key,required this.insuranceCost,required this.tripData});

  final InsuranceCost insuranceCost;
  final TripData tripData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: TravelCard(insuranceCost: insuranceCost,tripData: tripData,),
    );
  }
}

class TravelCard extends StatelessWidget {
  const TravelCard({
    Key? key,
    required this.insuranceCost,
    required this.tripData,
  }) : super(key: key);

  final InsuranceCost insuranceCost;
  final TripData tripData;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.33,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.teal,
                width: 3,
              ),
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(tripData.origin.toUpperCase(),style: TextStyle(fontSize: 20),),
                      Icon(Icons.arrow_forward_outlined),
                      Text(tripData.destination.toUpperCase(),style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Divider(
                    color: Colors.black
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(text:  TextSpan(style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                  children: [
                  const TextSpan(text: "Airline :  "),
                  TextSpan(text: tripData.airline, style: const TextStyle(color: Colors.blueAccent,)),
                  ],
                ),
                ),
              ],
            ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(text:  TextSpan(style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
                      children: [
                        const TextSpan(text: "Travel Date :"),
                        TextSpan(text: DateFormat('yyyy-MM-dd ').format(tripData.tripDateTime), style: const TextStyle(color: Colors.indigo,)),
                      ],
                    ),
                    ),
                  ],
                ),

                Cost(insuranceCost: insuranceCost),
            ]
            ),
          ),
        ),
      ),
    );
  }
}



class Cost extends StatelessWidget {
  const Cost({
    Key? key,
    required this.insuranceCost,
  }) : super(key: key);

  final InsuranceCost insuranceCost;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
        buildInsuranceText(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: ()  {
            },
            child: const Text('Pay now'),
          ),
        ),
      ],
    );
  }

  Widget buildInsuranceText() {
    String srr=String.fromCharCode(2193);
    if(insuranceCost.currentCost > insuranceCost.actualCost){
      return Row(
        children: [
        const Text("The cost of travel insurance is :"),
        Text(insuranceCost.currentCost.toString())
      ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      RichText(text:  TextSpan(style: TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.bold),
          children: [
        const TextSpan(text: "The cost of travel insurance is discounted : "),
        TextSpan(text: insuranceCost.actualCost.toString(),style: const TextStyle(decoration: TextDecoration.lineThrough,color: Colors.blueGrey,decorationStyle: TextDecorationStyle.solid,
        )
        ),
        TextSpan(text: " "+insuranceCost.currentCost.toString(), style: const TextStyle(color: Colors.indigo,)),
        // TextSpan(text: " ("+ (100-((insuranceCost.currentCost*100)/insuranceCost.actualCost)).toString()+ "%  )")
      ]
      )
      ),
    ],
    );
  }
}