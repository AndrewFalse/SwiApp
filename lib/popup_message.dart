import 'package:flutter/physics.dart';
import 'package:flutter/material.dart';

class PopUpMessage extends StatefulWidget {
  final String title; // 'Название' для отображения в сообщении

  const PopUpMessage({Key? key, required this.title}) : super(key: key);

  @override
  _PopUpMessageState createState() => _PopUpMessageState();
}

class _PopUpMessageState extends State<PopUpMessage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    // Создание контроллера анимации
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500), // Длительность анимации
    );

    // Добавление слушателя к контроллеру для вызова setState каждый раз, когда значение анимации меняется
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {});
      });

    // Запуск анимации с помощью SpringSimulation
    animationController.animateWith(
      SpringSimulation(
        SpringDescription(
          mass: 0.5,
          stiffness: 100,
          damping: 8,
        ),
        0.0, // начальное значение
        1.0, // конечное значение
        0.0, // скорость
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose(); // Освобождение ресурсов контроллера
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black26,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            'Записаны на ${widget.title}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
