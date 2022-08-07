import 'package:flutter/material.dart';
import 'package:test_web/controller/pomodoro_controller.dart';
import 'package:test_web/main.dart';
import 'package:test_web/shared/constants.dart';
import 'package:test_web/widgets/number_selector.dart';
import 'package:test_web/widgets/rounded_button.dart';

final PomodoroController pomodoroController = PomodoroController();

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.primary,
      body: Center(
        child: SizedBox(
          width: 312,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Label
              FittedBox(
                child: Container(
                  decoration: BoxDecoration(
                    color: constants.blue1,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: constants.blue3,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  child: AnimatedBuilder(
                    animation: pomodoroController,
                    builder: (context, child) {
                      return Row(
                        children: [
                          Icon(
                            pomodoroController.type == TimeType.focus
                                ? Icons.coffee
                                : Icons.battery_charging_full_sharp,
                            color: constants.blue3,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pomodoroController.type == TimeType.focus
                                ? 'Foco'
                                : 'Pausa',
                            style: TextStyle(
                              fontSize: 18,
                              color: constants.blue3,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Body
              SizedBox(
                width: double.infinity,
                height: 420,
                child: DefaultTextStyle(
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 210,
                    fontWeight: FontWeight.w700,
                    color: constants.blue3,
                  ),
                  child: AnimatedBuilder(
                    animation: pomodoroController,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Text(pomodoroController.getMinutes()),
                          Positioned(
                            top: 180,
                            child: Text(pomodoroController.getSeconds()),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              // Action Button
              AnimatedBuilder(
                animation: pomodoroController,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 50),
                      RoundedButton(
                        icon: Icons.restore,
                        onTap: () {
                          pomodoroController.reset();
                        },
                      ),
                      const SizedBox(width: 8),
                      RoundedButton(
                        icon: pomodoroController.isRunning
                            ? Icons.pause_outlined
                            : Icons.play_arrow_rounded,
                        big: true,
                        onTap: () {
                          if (pomodoroController.isRunning) {
                            pomodoroController.cancel();
                          } else {
                            pomodoroController.startTime();
                          }
                        },
                      ),
                    ],
                  );
                },
              ),

              // Spacer
              const SizedBox(height: 32),
              // Settings
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  color: constants.blue3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tempo de Foco'),
                          NumberSelector(
                            defaultTime: prefs.getInt('focusTime') ?? 25,
                            onChange: (time) async {
                              await prefs.setInt('focusTime', time);
                              pomodoroController.setFocusTime(time);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tempo de Pausa'),
                          NumberSelector(
                            defaultTime: prefs.getInt('relaxTime') ?? 5,
                            onChange: (time) async {
                              await prefs.setInt('relaxTime', time);
                              pomodoroController.setBreakTime(time);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
