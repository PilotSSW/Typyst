import Cocoa
import Files

var str = "Hello, playground"

do {
    for file in try Folder.current.subfolders {
        print(file.name)
        print(file.description)
    }
}
catch {
    print("Unable to find files")
}
