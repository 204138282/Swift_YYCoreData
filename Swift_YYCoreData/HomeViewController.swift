//
//  HomeViewController.swift
//  BanTanApp
//
//  Created by Jeson on 29/06/2017.
//  Copyright © 2017 Jeson. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    var tableView : UITableView?
    var names = [String]()
    var people = [NSManagedObject]()
    
    lazy var managerObjectContext: NSManagedObjectContext = {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let manager = appdelegate.persistentContainer.viewContext
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.layoutView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutView() {
        //        if tableView != nil {
        tableView = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        /*tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")*/
        self.view.addSubview(tableView!)
        //        }
        
        let rightItem = UIBarButtonItem.init(title: "添加", style: .plain, target: self, action: #selector(addItemAction(sender:)))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func addItemAction(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "添加姓名", message: "请输入一个名字", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "保存", style: .default) { (action :UIAlertAction!) in
            
            let textField = alert.textFields![0] as UITextField
            self.saveName(text: textField.text!)
            let indexPath = IndexPath(row: self.people.count - 1, section: 0)
            self.tableView?.insertRows(at: [indexPath], with: .automatic)
            self.tableView?.beginUpdates()
            self.tableView?.endUpdates()
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action: UIAlertAction) in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField: UITextField) in
        }
        present(alert, animated: true, completion: nil)
    }
    
    ///代理
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellid")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellid")
        }
        let ps = people[indexPath.row]
        cell?.textLabel?.text = ps.value(forKey: "name") as? String
        return cell!
    }
    
    
    /**
     *  查询CoreData中已有数据
     *
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //获取托管对象
        /*let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let managerObjectContext = appDelegate.persistentContainer.viewContext*/
        
        //创建获取请求
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Person")
        
        //执行查询
        do {
            let fetchedResults = try managerObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            if let result = fetchedResults {
                people = result
                tableView?.reloadData()
            }
        }catch {
            fatalError("获取失败")
        }
    }
    
    /**
     *  保存数据到CoreData
     *
     */
    private func saveName(text: String) {
        //1、获取托管对象
        /*let appdelegate = UIApplication.shared.delegate as! AppDelegate
         let managerObjectContext = appdelegate.persistentContainer.viewContext*/
        
        //2、建立entity
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managerObjectContext)
        let person = NSManagedObject.init(entity: entity!, insertInto: managerObjectContext)
        
        //3、保存文本框的值到person
        person.setValue(text, forKey: "name")
        
        //4、保存person到managerObjectContext,如果失败进行逻辑处理
        do {
            try managerObjectContext.save()
        }catch {
            fatalError("无法保存！")
        }
        
        //5、保存到数组中，更新UI
        people.append(person)
        
    }
}
