

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 late String  studentName, studentId, studyProgramId;
 late double studentGPA;
   

    getStudentName(name) {
      studentName = name;
    }
    getStudentId(id) {
      studentId = id;
    }
    getStudentProgramId(programId) {
      studyProgramId =  programId;
    }
    getstudentGPA(gpa) {
      studentGPA = double.parse(gpa);
    }
    createData(){
      print("Created");
      DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
       Map<String, dynamic> students = {
          "studentName": studentName,
          "studentID": studentId,
          "studyProgramId": studyProgramId,
          "studentgpa": studentGPA

       };
       documentReference.set(students).whenComplete(() {
          print("$studentName created");
       });
    }
    readData(){
      {

      } 
        
    }
    
    updateData(){
      DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
       Map<String, dynamic> students = {
          "studentName": studentName,
          "studentID": studentId,
          "studyProgramId": studyProgramId,
          "studentgpa": studentGPA

       };
       documentReference.set(students).whenComplete(() {
          print("$studentName updated");
      
    });
    }
    deleteData(){
      DocumentReference documentReference = FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
       
       documentReference.delete().whenComplete(() {
          print("$studentName deleted");
      
    });
    }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("MyClass", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10, bottom: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText:  "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2)
                    )
                ),
                onChanged: (String name) {
                getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText:  "Student Id",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2)
                    )
                ),
                onChanged: (String id) {
                getStudentId(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText:  "Study Program Id",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2)
                    )
                ),
                onChanged: (String programId) {
                getStudentProgramId(programId);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText:  "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2)
                    )
                ),
                onChanged: (String gpa) {
                getstudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () { 
                    createData();
                   },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 8))
      
                  ),
                  child: const Text("Create",),
                  
                ),
                const SizedBox(width: 30,),
                ElevatedButton(
                  onPressed: () { 
                    readData();
                   },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 8))
      
                  ),
                  child: const Text(" Read",),
                  
                ),
                const SizedBox(width: 30,),
                ElevatedButton(
                  onPressed: () {
                    updateData();
                    },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 8))
      
                  ),
                  child: const Text("Update",),
                  
                ),
                const SizedBox(width: 30,),
      
                ElevatedButton(
                  onPressed: () { 
                    deleteData();
                   },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                    textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 8))
      
                  ),
                  child: const Text ("Delete",),
                  
                ),
      
      
      
              ],
            ),
            Row(
              children: const [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Student ID")),
                Expanded(child: Text("Program ID")),
                Expanded(child: Text("GPA")),
              
              
              ],
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MyStudents").snapshots(),
              builder: (context, AsyncSnapshot snapshots)   {
               // if (!snapshots.hasData)  {
                  return  ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshots.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =  snapshots.data.docs[index];
                        return  Row(
                          children: [
                            Expanded(
                              child: Text(documentSnapshot["studentName"] ),
                              ),
                              Expanded(
                              child: Text(documentSnapshot["studentID"]),
                              ),
                              Expanded(
                              child: Text(documentSnapshot["studyProgramId"]),
                              ),
                              Expanded(
                              child: Text(documentSnapshot["studentgpa"].toString()),
                              ),
                          ],
                        );
                    
                      }
                    
                      );
                  
                
                //} else {
                 // const Align (
                     //alignment: FractionalOffset.bottomCenter,
                     //child: CircularProgressIndicator(),
                  //);
                }
      
             // },
            )
          
          ],
        ),
      ),
      
      
    );
    
  }
}