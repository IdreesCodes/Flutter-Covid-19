import 'package:covid_tracker/Model/WorldStatesModel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'countries_list.dart';

import '../Services/stats_services.dart';
class WorldStats extends StatefulWidget {
  const WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats>  with TickerProviderStateMixin {
  StatesServices statesServices  = StatesServices();

  late final AnimationController _controller  = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this)..repeat();



  @override
  void dispose(){
    super.initState();
    _controller.dispose();
  }
  final colorsList = <Color> [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              FutureBuilder(
                  future: statesServices.fetchWorldStatsRecord(),
                  builder: (context , AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCube(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,

                        ),

                    );

                }
                else {
                  return Column (
                  children: [
                    PieChart(dataMap:  {
                      "Total": double.parse(snapshot.data!.cases!.toString()),
                      "Recoverd": double.parse(snapshot.data!.recovered!.toString()),
                      "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                    },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
                        animationDuration: Duration(seconds: 3),
                        chartType: ChartType.ring,
                        colorList: colorsList

                    ),

                    Padding(
                      padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                      child: Card(
                        child: Column(

                          children: [
                            ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            ReuseableRow(title: 'Deaths', value:snapshot.data!.deaths.toString()),
                            ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                            ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                            ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                            ReuseableRow(title: 'Test Per Million ', value: snapshot.data!.testsPerOneMillion.toString()),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                    },
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),

                            color: Color(0xff1aa260),

                          ),

                          child: Center(child: Text('Track Countries'),)


                      ),
                    ),
                  ]
                  );
                    }

              }),


            ],
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10,top: 10,bottom: 5),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),

            ],
          ),
          SizedBox(
            height: 10,
          ),
          Divider(

          )
        ],
      ),
    );
  }
}

