import Cocoa
import FilesProvider

var str = "Hello, playground"

let documentsProvider = LocalFileProvider()

documentsProvider.contentsOfDirectory(path: "/", completionHandler: {
    contents, error in
    for file in contents {
        print("Name: \(file.name)")
        print("Size: \(file.size)")
        print("Creation Date: \(file.creationDate)")
        print("Modification Date: \(file.modifiedDate)")
    }
})
