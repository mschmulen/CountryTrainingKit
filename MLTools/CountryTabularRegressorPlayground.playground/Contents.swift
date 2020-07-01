import Cocoa
import CreateML

let rootPath = "/Users/schmulen/trees/github/mschmulen/CountryTrainingKit"

let trainingFile = URL(fileURLWithPath: "\(rootPath)/MLdata/flagData_v5.csv")
var dataTable = try! MLDataTable(contentsOf: trainingFile)

func exportModel(regressor: MLRegressor, fileName: String = "CountryFlagGameRegressor.mlmodel") {
    // ------------------------------------
    // Save the model
    let modelMetadata = MLModelMetadata(author: "Matt Schmulen",
                                        shortDescription: "Predicts the number of guesses to get the flag for a country.",
                                        version: "1.0")
    let mlModelsFolder = URL(fileURLWithPath:"\(rootPath)/CoreMLModels")
    try! regressor.write(
        to: mlModelsFolder.appendingPathComponent(fileName),
        metadata: modelMetadata
    )
    // ------------------------------------
}

enum RegressorModelType {
    case MLLinearRegressor
    case MLDecisionTreeRegressor
    case MLRandomForestRegressor
    case MLBoostedTreeRegressor
    case MLRegressor
}

struct ModelResults {
    var trainingMaxError: Double
    var trainingRootMeanSquaredError: Double
    var validationMaxError: Double
    var validationRootMeanSquareError: Double
}


// Build some regressors to play around with
var regressors:[MLRegressor] = []
let regressorLinear = try! MLLinearRegressor(
    trainingData: dataTable,
    targetColumn: "numberOfGuesses",
    featureColumns: ["playerRegion","playerLanguage","playerNumberOfDaysOld","countryFlagEmoji","deviceAlternateLanguage"] //""
)
regressors.append(
    .linear(regressorLinear)
)
let regressorDecisionTree = try! MLDecisionTreeRegressor(
    trainingData: dataTable,
    targetColumn: "numberOfGuesses",
    featureColumns: ["playerRegion","playerLanguage","playerNumberOfDaysOld","countryFlagEmoji","deviceAlternateLanguage"] //""
)
regressors.append(
    .decisionTree(regressorDecisionTree)
)
let regressorRandomForest = try! MLRandomForestRegressor(
    trainingData: dataTable,
    targetColumn: "numberOfGuesses",
    featureColumns: ["playerRegion","playerLanguage","playerNumberOfDaysOld","countryFlagEmoji","deviceAlternateLanguage"] //""
)
regressors.append(
    .randomForest(regressorRandomForest)
)
let regressorBoostedTree = try! MLBoostedTreeRegressor(
    trainingData: dataTable,
    targetColumn: "numberOfGuesses",
    featureColumns: ["playerRegion","playerLanguage","playerNumberOfDaysOld","countryFlagEmoji","deviceAlternateLanguage"] //""
)
regressors.append(
    .boostedTree(regressorBoostedTree)
)

// dump them all
//for regressor in regressors {
//    print( "--------------------------------")
//    print( "\(regressor.description)")
//    print( "trainingMetrics.rootMeanSquaredError: \(regressor.trainingMetrics.rootMeanSquaredError)")
//    print( "trainingMetrics.maximumError: \(regressor.trainingMetrics.maximumError)")
//    print( "--------------------------------")
//}
//print( "done ")

let bestRootMeanError = regressors.reduce(regressors[0]) { (prev, regressor) -> MLRegressor in
    if regressor.trainingMetrics.rootMeanSquaredError < prev.trainingMetrics.rootMeanSquaredError {
        return regressor
    } else {
        return prev
    }
}

print( "----------------")
print( "bestRootMeanError: \(bestRootMeanError.description)")
print( "trainingMetrics.rootMeanSquaredError: \(bestRootMeanError.trainingMetrics.rootMeanSquaredError)")
print( "trainingMetrics.maximumError: \(bestRootMeanError.trainingMetrics.maximumError)")
print( "validationMetrics.rootMeanSquaredError: \(bestRootMeanError.validationMetrics.rootMeanSquaredError)")
print( "validationMetrics.maximumError: \(bestRootMeanError.validationMetrics.maximumError)")
print( "----------------")
//exportModel(regressor: bestRootMeanError)

exportModel(regressor: .boostedTree(regressorBoostedTree))



print( "done")

// ------------------------------------------------------------------------------------
//let bestMaximumError = regressors.reduce(regressors[0]) { (prev, regressor) -> MLRegressor in
//    if regressor.trainingMetrics.maximumError < prev.trainingMetrics.maximumError {
//        return regressor
//    } else {
//        return prev
//    }
//}
//
//print( "--------------------------------")
//print( "bestMaximumError: \(bestMaximumError.description)")
//print( "trainingMetrics.rootMeanSquaredError: \(bestMaximumError.trainingMetrics.rootMeanSquaredError)")
//print( "trainingMetrics.maximumError: \(bestMaximumError.trainingMetrics.maximumError)")
//print( "--------------------------------")
// ------------------------------------------------------------------------------------

