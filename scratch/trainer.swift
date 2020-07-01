import Cocoa
import CreateML
let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: "//Users/schmulen/trees/github/jumptack/MLApp/data/MoviesCSV.csv"))
let model = try MLRecommender(trainingData: trainingData, userColumn: "user_id", itemColumn: "movie_id", ratingColumn: "rating_id")
let metrics = model.evaluation(on: trainingData, userColumn: "user_id", itemColumn: "movie_id")
let recs = try model.recommendations(fromUsers: ["D"])
print(recs)
let metadata = MLModelMetadata(author: "Matt Schmulen", shortDescription: "A model trained to handle recommendations", version: "1.0")
try model.write(to: URL(fileURLWithPath: "/Users/schmulen/trees/github/jumptack/MLApp/trainingMovieRecommender.mlmodel"), metadata: metadata)


