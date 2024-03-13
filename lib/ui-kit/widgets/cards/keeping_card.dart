// ignore_for_file: unnecessary_null_comparison, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:newhonekapp/app/repository/keeping.dart';

class KeepingCamera extends StatefulWidget {
  final String room_name;
  final String position;
  final String status;
  final bool checked;
  final int id;

  const KeepingCamera(
      {super.key,
      required this.room_name,
      required this.checked,
      required this.position,
      required this.status, required this.id});

  @override
  // ignore: no_logic_in_create_state
  createState() => _KeepingCamera();
}

class _KeepingCamera extends State<KeepingCamera> {
  late bool done = widget.checked;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
            ),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Color(0xFFF4F5F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Ionicons.bed_outline),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.room_name,
                                          style: GoogleFonts.roboto(
                                            fontSize: 20.0,
                                            color: Color.fromARGB(
                                                255, 63, 75, 109),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                Text(
                                  widget.position,
                                  style: GoogleFonts.roboto(
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 87, 94, 116),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Ionicons.hand_left_outline),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          widget.status,
                                          style: GoogleFonts.roboto(
                                            fontSize: 18.0,
                                            color:
                                                Color.fromRGBO(33, 45, 82, 1),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                            onPressed: () async => {
                                                  if (await updateKeepingStatus({
                                                    "id": widget.id,
                                                    "done": done ? 0 : 1
                                                  }))
                                                    {
                                                      setState(
                                                        () {
                                                          done = !done;
                                                        },
                                                      ),
                                                      getKeepings()
                                                    }
                                                },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: done
                                                    ? Colors.green
                                                    : Colors.redAccent),
                                            child: Text(
                                              done ? 'Ready' : 'Pending',
                                              style: GoogleFonts.roboto(
                                                fontSize: 20.0,
                                                color: Color.fromARGB(
                                                    255, 62, 53, 75),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ]))),
                ],
              ),
            )));
  }
}
