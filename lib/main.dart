import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AudioPlayer _audioPlayer;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        await _audioPlayer.play(AssetSource('audio/timun_mas.mp3'));
        await _audioPlayer.setPlaybackRate(_playbackSpeed);
        break;
      case 1:
        await _audioPlayer.pause();
        break;
      case 2:
        await _audioPlayer.stop();
        break;
    }
  }

  void _changePlaybackSpeed() async {
    setState(() {
      _playbackSpeed = _playbackSpeed >= 4.0 ? 1.0 : _playbackSpeed + 1.0;
    });
    if (_selectedIndex == 0) {
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Cerita Rakyat"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.lightGreen[100],
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Timun Mas dan Buto Ijo",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset("assets/images/timunmas.png"),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ini dimulai dengan seorang janda tua tanpa anak yang hidup sendirian. Dia mengunjungi Buto Ijo, raksasa yang kuat, meminta untuk diberkati dengan seorang anak. Buto Ijo memberinya mentimun besar dan memintanya berjanji untuk memberikan anak pertamanya kepadanya untuk dimakan.\n'
                    '\nKetika janda tua itu pulang, dia menemukan bayi perempuan di dalam mentimun. Dia memberi nama Timun Mas dan lupa tentang janjinya.\n'
                    '\nSuatu hari, ketika Timun Mas sudah remaja, Buto Ijo mampir ke rumah janda tua itu memintanya untuk memenuhi janjinya. Janda itu menyuruh Timun Mas melarikan diri, dengan membekalinya persediaan biji mentimun ajaib, jarum dan garam.\n'
                    '\nButo Ijo mengejar Timun Mas tetapi dia selalu berhasil melarikan diri dengan menggunakan sihir ajaib ibunya. Buto Ijo akhirnya dikalahkan ketika Timun Mas menaburkan garam di sekitarnya yang berubah menjadi lautan dan menelannya ke dalam laut.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightGreen,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow_rounded),
              label: 'play',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pause),
              label: 'pause',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.stop),
              label: 'stop',
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.fast_forward),
                onPressed: _changePlaybackSpeed,
                tooltip: 'Change Playback Speed',
              ),
              label: 'Speed: ${_playbackSpeed}x',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
