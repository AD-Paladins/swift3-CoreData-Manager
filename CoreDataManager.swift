//
//  CoreDataManager.swift
//  appgenerica
//

import Foundation
import CoreData

class CoreDataManager{
    static func listaDe<T: NSManagedObject>(entity: T.Type,
                        multiPredicate: [NSPredicate]? = nil,
                        sortDescriptor: [NSSortDescriptor]? = nil,
                        context: NSManagedObjectContext = CoreDataStack.managedObjectContext) -> NSMutableArray? {
        
        let fetchRequest = NSFetchRequest<T>(entityName: NSStringFromClass(T.self))
        
        var predicates = [NSPredicate]()
        if(multiPredicate != nil){
            for predic in multiPredicate!{
                predicates.append(predic)
            }
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        if sortDescriptor != nil {
            fetchRequest.sortDescriptors = sortDescriptor!
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let searchResult = try context.fetch(fetchRequest)
            if searchResult.count > 0 {
                // returns mutable copy of result array
                return NSMutableArray.init(array: searchResult)
            } else {
                // returns nil in case no object found
                return nil
            }
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /**
     * Predicados
     * Lista de funciones para utilizar como predicados
     */
    
    static func Contiene(texto: String) ->NSPredicate{
        return NSPredicate(format: "name contains[c] %@", texto)
    }
    
    static func Donde(campo: String, es esto: String) ->NSPredicate{
        return NSPredicate(format: "\(campo) = %@", esto)
    }
    
//    static func adsad() -> NSPredicate{
//        return NSPredicate(format: "name contains[c] %@ AND nickName contains[c] %@", argumentArray: [name, nickname])
//        return NSPredicate(format: "name = %@ AND nickName = %@", argumentArray: [name, nickname])
//    }
    
    
    
}


        //USAGE
        
        // Add Sort Descriptor
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
        // Add Predicate
        var predicates = [NSPredicate]()
        predicates.append(NSPredicate(format: "name = someName"))
        predicates.append(NSPredicate(format: "%K = %@", "list.name", "Home"))
        
        let datos = CoreDataManager.listaDe(entity: Usuario.self, multiPredicate: predicates, sortDescriptor: [sortDescriptor])
        
        for dato in datos as! [NSManagedObject] {
            print(dato.value(forKey: "property") ?? "FETCH GENERICO SINDATOS")
        }
        
