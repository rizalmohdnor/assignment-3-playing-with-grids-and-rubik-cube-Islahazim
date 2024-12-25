import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  void rotateFaceClockwise(int faceIndex) {
    List<Color> tempFace = [...faces[faceIndex]];
    faces[faceIndex] = [
      tempFace[2], tempFace[0],
      tempFace[3], tempFace[1]
    ];
  }

  void rotateTop() {
    rotateFaceClockwise(4);
    List<Color> temp = [faces[0][0], faces[0][1]];
    faces[0][0] = faces[1][0];
    faces[0][1] = faces[1][1];
    faces[1][0] = faces[3][0];
    faces[1][1] = faces[3][1];
    faces[3][0] = faces[2][0];
    faces[3][1] = faces[2][1];
    faces[2][0] = temp[0];
    faces[2][1] = temp[1];
  }

  void rotateBottom() {
    rotateFaceClockwise(5);
    List<Color> temp = [faces[0][2], faces[0][3]];
    faces[0][2] = faces[1][2];
    faces[0][3] = faces[1][3];
    faces[1][2] = faces[3][2];
    faces[1][3] = faces[3][3];
    faces[3][2] = faces[2][2];
    faces[3][3] = faces[2][3];
    faces[2][2] = temp[0];
    faces[2][3] = temp[1];
  }

  void rotateLeft() {
    rotateFaceClockwise(1);
    List<Color> temp = [faces[0][0], faces[0][2]];
    faces[0][0] = faces[4][0];
    faces[0][2] = faces[4][2];
    faces[4][0] = faces[3][3];
    faces[4][2] = faces[3][1];
    faces[3][3] = faces[5][0];
    faces[3][1] = faces[5][2];
    faces[5][0] = temp[0];
    faces[5][2] = temp[1];
  }

  void rotateRight() {
    rotateFaceClockwise(2);
    List<Color> temp = [faces[0][1], faces[0][3]];
    faces[0][1] = faces[5][1];
    faces[0][3] = faces[5][3];
    faces[5][1] = faces[3][2];
    faces[5][3] = faces[3][0];
    faces[3][2] = faces[4][1];
    faces[3][0] = faces[4][3];
    faces[4][1] = temp[0];
    faces[4][3] = temp[1];
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2x2 Rubik\'s Cube'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text('Top'),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[4]),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text('Left'),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[1]),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[0]),
              ),
              Column(
                children: [
                  const Text('Right'),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: buildFace(cube.faces[2]),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              const Text('Bottom'),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[5]),
              ),
            ],
          ),
          Column(
            children: [
              const Text('Back'),
              SizedBox(
                height: 100,
                width: 100,
                child: buildFace(cube.faces[3]),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => setState(() => cube.rotateTop()),
                icon: const Icon(Icons.arrow_upward),
                tooltip: 'Rotate Top',
              ),
              IconButton(
                onPressed: () => setState(() => cube.rotateBottom()),
                icon: const Icon(Icons.arrow_downward),
                tooltip: 'Rotate Bottom',
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => setState(() => cube.rotateLeft()),
                icon: const Icon(Icons.rotate_left),
                tooltip: 'Rotate Left',
              ),
              IconButton(
                onPressed: () => setState(() => cube.rotateRight()),
                icon: const Icon(Icons.rotate_right),
                tooltip: 'Rotate Right',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
