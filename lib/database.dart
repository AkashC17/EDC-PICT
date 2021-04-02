import 'package:cloud_firestore/cloud_firestore.dart';

class Database {

  final String uid;

  Database(this.uid);


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  CollectionReference quiz = FirebaseFirestore.instance.collection('quiz');

  CollectionReference leaderboard = FirebaseFirestore.instance.collection('leaderboard');

  CollectionReference ID = FirebaseFirestore.instance.collection('ID');



  Future<void> updateDetails(String name, String division, String Class,
      String branch, int currentRank,int globalRank,int currentMarks,int overallMarks, bool admin,String avatar,bool taken,bool firstTime,String id,String emailId,bool currentTaken) async
  {
    return await users.doc(uid).set(
        {
          "uid": uid,
          "division": division,
          "name": name,
          "class": Class,
          "branch": branch,
          "currentRank": currentRank,
          "globalRank": globalRank,
          "admin": admin,
          "avatar":avatar,
          "currentMarks": currentMarks,
          "overallMarks": overallMarks,
          "quizTaken": taken,
          "firstTime": firstTime,
          "id":id,
          "emailId":emailId,
          "currentTaken":currentTaken
        }
    );
  }

  Future<void> createQuiz(Map<String,List<String>> quizz, String time,String endTime,bool updated,bool rankUpdated,bool overallRankUpdated)async
  {
     await quiz.doc(uid).set(
      {
        "quiz": quizz,
        "time": time,
        "endTime": endTime,
        "updated": updated,
        "rankUpdated": rankUpdated,
        "overallRankUpdated": overallRankUpdated
      }
    );
    return await leaderboard.doc(uid).set({});
  }

  Future<void> updated(bool updated)async
  {
    return await quiz.doc(uid).update(
        {
          "updated":updated
        }
    );
  }


  Future<void> updateMarks(int marks,int overallMarks)async
  {
    return await users.doc(uid).update(
      {
        "currentMarks":marks,
        "overallMarks": overallMarks
      }
    );
  }

  Future<void> updateBool(bool taken)async
  {
    return await users.doc(uid).update(
      {
        "quizTaken":taken
      }
    );
  }


  Future<void> updateBool1(bool taken)async
  {
    return await users.doc(uid).update(
        {
          "firstTime":taken
        }
    );
  }

  Future<void> currentTaken(bool taken)async
  {
    return await users.doc(uid).update(
        {
          "currentTaken":taken
        }
    );
  }

  Future<void> updateCurrentRank(int currentRank)async
  {
    return await users.doc(uid).update(
        {
          "currentRank": currentRank
        }
    );
  }

  Future<void> updateOverallRank(int overallRank)async
  {
    return await users.doc(uid).update(
        {
          "globalRank": overallRank
        }
    );
  }

  Future<void> updateResponses(String id,Map<String,String> responses)async
  {
    return await users.doc(uid).update(
        {
          "id":id,
          "responses":responses
        }
    );
  }

  Future<void> updateEmailId(String emailId)async
  {
    return await users.doc(uid).update(
        {
          "emailId":emailId
        }
    );
  }

  Future<void> updateLeaderboard(String id,String no, List l)async
  {
    return await leaderboard.doc(id).update(
      {
        no: l
      }
    );
  }

  Future<void> updateOverallLeaderboard(String no, List l)async
  {
    return await leaderboard.doc("globalLeaderboard").update(
        {
          no: l
        }
    );
  }

  Future<void> rankUpdated(bool up)async
  {
    return await quiz.doc(uid).update(
        {
          "rankUpdated": up
        }
    );
  }

  Future<void> overallRankUpdated(bool up)async
  {
    return await quiz.doc(uid).update(
        {
          "overallRankUpdated": up
        }
    );
  }

  Future<void> updateQuizId(String up)async
  {
    return await ID.doc("id").update(
        {
          "i": up
        }
    );
  }



}

