
import UIKit

/*
 Protocol to make sure all segues are handled safely. More on this techinque:
 https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
 */
protocol SegueHandler {
  associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler //Default implementation...
  where Self: UIViewController, //for view controllers...
SegueIdentifier.RawValue == String { //who have String segue identifiers.
  
  func performSegueWithIdentifier(identifier: SegueIdentifier, sender: AnyObject? = nil) {
    performSegue(withIdentifier: identifier.rawValue,
                               sender: sender)
  }
  
  func identifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
    guard
      let stringIdentifier = segue.identifier,
      let identifier = SegueIdentifier(rawValue: stringIdentifier) else {
        fatalError("Couldn't find identifier for segue!")
    }
    
    return identifier
  }
}
