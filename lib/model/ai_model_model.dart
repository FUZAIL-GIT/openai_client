class AiModel {
  final String modelName;
  final String parentModelName;
  final String modelDescription;
  final int modelMaxTokens;
  final DateTime modelTrainingDataDate;

  AiModel({
    required this.modelName,
    required this.parentModelName,
    required this.modelDescription,
    required this.modelMaxTokens,
    required this.modelTrainingDataDate,
  });
}
