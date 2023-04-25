class CompleteRequest {
  int userId;
  int termId;
  CompleteRequest({required this.termId, required this.userId});

  Map<String, int> toJson() {
    return {"userId": userId, "termId": termId};
  }
}
