//
// Autogenerated by Natalie - Storyboard Generator Script.
// http://blog.krzyzanowskim.com
//

import UIKit

//MARK: - Storyboards
struct Storyboards {

    struct Main {

        static let identifier = "Main"

        static var storyboard:UIStoryboard {
            return UIStoryboard(name: self.identifier, bundle: nil)
        }

        static func instantiateInitialViewController() -> CustomNavigationController! {
            return self.storyboard.instantiateInitialViewController() as! CustomNavigationController
        }

        static func instantiateViewControllerWithIdentifier(identifier: String) -> UIViewController {
            return self.storyboard.instantiateViewControllerWithIdentifier(identifier) as! UIViewController
        }
    }
}

//MARK: - ReusableKind
enum ReusableKind: String, Printable {
    case TableViewCell = "tableViewCell"
    case CollectionViewCell = "collectionViewCell"

    var description: String { return self.rawValue }
}

//MARK: - SegueKind
enum SegueKind: String, Printable {    
    case Relationship = "relationship" 
    case Show = "show"                 
    case Presentation = "presentation" 
    case Embed = "embed"               
    case Unwind = "unwind"             

    var description: String { return self.rawValue } 
}

//MARK: - SegueProtocol
public protocol IdentifiableProtocol: Equatable {
    var identifier: String? { get }
}

public protocol SegueProtocol: IdentifiableProtocol {
}

public func ==<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

public func ~=<T: SegueProtocol, U: SegueProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - ReusableProtocol
public protocol ReusableProtocol: IdentifiableProtocol {
    var viewType: UIView.Type? {get}
}

public func ==<T: ReusableProtocol, U: ReusableProtocol>(lhs: T, rhs: U) -> Bool {
   return lhs.identifier == rhs.identifier
}

//MARK: - Protocol Implementation
extension UIStoryboardSegue: SegueProtocol {
}

extension UICollectionReusableView: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

extension UITableViewCell: ReusableProtocol {
    public var viewType: UIView.Type? { return self.dynamicType}
    public var identifier: String? { return self.reuseIdentifier}
}

//MARK: - UIViewController extension
extension UIViewController {
    func performSegue<T: SegueProtocol>(segue: T, sender: AnyObject?) {
       performSegueWithIdentifier(segue.identifier, sender: sender)
    }
}

//MARK: - UICollectionViewController

extension UICollectionViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableCellWithReuseIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forCellWithReuseIdentifier: identifier)
        }
    }

    func dequeueReusableSupplementaryViewOfKind<T: ReusableProtocol>(elementKind: String, withReusable reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.collectionView!.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusable<T: ReusableProtocol>(reusable: T, forSupplementaryViewOfKind elementKind: String) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.collectionView?.registerClass(type, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
        }
    }
}
//MARK: - UITableViewController

extension UITableViewController {

    func dequeueReusableCell<T: ReusableProtocol>(reusable: T, forIndexPath: NSIndexPath!) -> AnyObject {
        return self.tableView!.dequeueReusableCellWithIdentifier(reusable.identifier!, forIndexPath: forIndexPath)
    }

    func registerReusableCell<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
            self.tableView?.registerClass(type, forCellReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooter<T: ReusableProtocol>(reusable: T) -> AnyObject? {
        if let identifier = reusable.identifier {
            return self.tableView?.dequeueReusableHeaderFooterViewWithIdentifier(identifier)
        }
        return nil
    }

    func registerReusableHeaderFooter<T: ReusableProtocol>(reusable: T) {
        if let type = reusable.viewType, identifier = reusable.identifier {
             self.tableView?.registerClass(type, forHeaderFooterViewReuseIdentifier: identifier)
        }
    }
}

//MARK: - ShowsViewController
extension UIStoryboardSegue {
    func selection() -> ShowsViewController.Segue? {
        if let identifier = self.identifier {
            return ShowsViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowsViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case SegueShowDetail = "SegueShowDetail"

        var kind: SegueKind? {
            switch (self) {
            case SegueShowDetail:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case SegueShowDetail:
                return ShowDetailViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}
extension ShowsViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case ShowCell = "ShowCell"

        var kind: ReusableKind? {
            switch (self) {
            case ShowCell:
                return ReusableKind(rawValue: "collectionViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case ShowCell:
                return ShowCollectionViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - SeasonEpisodesViewController
extension SeasonEpisodesViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case EpisodeCell = "EpisodeCell"

        var kind: ReusableKind? {
            switch (self) {
            case EpisodeCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowDetailViewController
extension UIStoryboardSegue {
    func selection() -> ShowDetailViewController.Segue? {
        if let identifier = self.identifier {
            return ShowDetailViewController.Segue(rawValue: identifier)
        }
        return nil
    }
}

extension ShowDetailViewController { 

    enum Segue: String, Printable, SegueProtocol {
        case SegueShowOverview = "SegueShowOverview"
        case SegueShowSeasons = "SegueShowSeasons"
        case SegueShowGenres = "SegueShowGenres"
        case SegueShowMore = "SegueShowMore"
        case SegueSeasonEpisodes = "SegueSeasonEpisodes"

        var kind: SegueKind? {
            switch (self) {
            case SegueShowOverview:
                return SegueKind(rawValue: "embed")
            case SegueShowSeasons:
                return SegueKind(rawValue: "embed")
            case SegueShowGenres:
                return SegueKind(rawValue: "embed")
            case SegueShowMore:
                return SegueKind(rawValue: "embed")
            case SegueSeasonEpisodes:
                return SegueKind(rawValue: "show")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var destination: UIViewController.Type? {
            switch (self) {
            case SegueShowOverview:
                return ShowOverviewViewController.self
            case SegueShowSeasons:
                return ShowSeasonViewController.self
            case SegueShowGenres:
                return ShowGenresViewController.self
            case SegueShowMore:
                return ShowMoreViewController.self
            case SegueSeasonEpisodes:
                return SeasonEpisodesViewController.self
            default:
                assertionFailure("Unknown destination")
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}

//MARK: - CustomNavigationController

//MARK: - ShowOverviewViewController

//MARK: - ShowSeasonViewController
extension ShowSeasonViewController { 

    enum Reusable: String, Printable, ReusableProtocol {
        case SeasonCell = "SeasonCell"

        var kind: ReusableKind? {
            switch (self) {
            case SeasonCell:
                return ReusableKind(rawValue: "tableViewCell")
            default:
                preconditionFailure("Invalid value")
                break
            }
        }

        var viewType: UIView.Type? {
            switch (self) {
            case SeasonCell:
                return SeasonTableViewCell.self
            default:
                return nil
            }
        }

        var identifier: String? { return self.description } 
        var description: String { return self.rawValue }
    }

}


//MARK: - ShowGenresViewController

//MARK: - ShowMoreViewController
