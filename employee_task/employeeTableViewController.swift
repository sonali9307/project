//
//  employeeTableViewController.swift
//  employee_task
//
//  Created by Mac on 07/12/19.
//  Copyright © 2019 Varsha. All rights reserved.
//

import UIKit
import SQLite3

struct jsonstruct:Decodable {
    let id:String
    let employee_name:String
    let employee_salary:String
    let employee_age:String
}
class employeeTableViewController: UITableViewController
{

    var employeearr=[jsonstruct]()



    @IBAction func insert_record(_ sender: Any)
    {

        let dir=try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)

        let dbpath=dir.appendingPathComponent("employee.sqlite")

        print(dbpath)
        let filemanager=FileManager()

        if filemanager.fileExists(atPath: dbpath.path)
        {
            print("database already present")
        }
        else
        {
            filemanager.createFile(atPath: dbpath.path, contents: nil, attributes: nil)
        }

        var ptr:OpaquePointer?=nil
        var temp = Employee()
        if sqlite3_open(dbpath.path, &ptr)==SQLITE_OK
        {
            let query=String.init(format: "insert into employee values('%@','%@','%@','%@'")
            print(query)

            if sqlite3_exec(ptr, query, nil, nil, nil)==SQLITE_OK
            {
                print("inserted")
            }
        }
        sqlite3_close(ptr)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        getdata()
    }
func getdata()
{
      let url=URL(string: "http://dummy.restapiexample.com/api/v1/employees")
    URLSession.shared.dataTask(with: url!) { (data, response, error) in

        do{
            if error==nil{
                self.employeearr=try JSONDecoder().decode([jsonstruct].self, from: data!)
                for mainarray in self.employeearr{
                    print(mainarray.employee_name)

                DispatchQueue.main.async
                    {
                    self.tableView.reloadData()
                   }
            }
        }
}
    catch{
          print("error")
        }
     }.resume()
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.employeearr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! TableViewCell
      cell.label1.text=self.employeearr[indexPath.row].employee_name

        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc:detailsViewController=self.storyboard?.instantiateViewController(withIdentifier: "svc") as! detailsViewController

        svc.strenamelabel=employeearr[indexPath.row].employee_name
        svc.streidlabel=employeearr[indexPath.row].id
        svc.strempsallabel=employeearr[indexPath.row].employee_salary
        svc.stragelabel=employeearr[indexPath.row].employee_age
        
        self.navigationController?.pushViewController(svc, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
