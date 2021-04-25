//
//  ViewController.swift
//  leftTable3levelDemo
//
//  Created by Nguyen Hoan on 9/10/20.
//  Copyright © 2020 Nguyen Hoan. All rights reserved.
//
struct MenuRootData {
    let level = 0
    var title: String?
    var open = false
    var child: [MenuParentData]?
}
struct MenuParentData {
    let level = 1
    var title: String?
    var open = false
    var child: [MenuChildData]?
    var index: Int?
}
struct MenuChildData {
    let level = 2
    var title: String?
    var index: Int?
}
import UIKit

class ViewController: UIViewController{
    var dataMenu: [MenuRootData]  = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "Root", bundle: nil), forCellReuseIdentifier: "Root")
        tableView.register(UINib(nibName: "Parent", bundle: nil), forCellReuseIdentifier: "Parent")
        tableView.register(UINib(nibName: "Child", bundle: nil), forCellReuseIdentifier: "Child")
        setupMenu()
    }
    func setupMenu(){
        let lichcongtac = MenuRootData(title: "Lịch công tác", open: false, child: getDataChildLichCongtac())
        let vanbandieuhanh = MenuRootData(title: "Văn bản điều hành", open: false, child: getDataChildVBDieuhanh())
        let nhiemvuchinhphu = MenuRootData(title: "Nhiệm vụ chính phủ giao", open: false, child: getDataChildNhiemVuCP())
        dataMenu.append(lichcongtac)
        dataMenu.append(vanbandieuhanh)
        dataMenu.append(nhiemvuchinhphu)
        setIndexData()
//        print(dataMenu[1].child!)
    }
    func setIndexData(){
        if dataMenu.isEmpty {
            return
        }
        for i in 0...dataMenu.count - 1 {
            var index = 1
            if dataMenu[i].child!.isEmpty || !dataMenu[i].open{
                continue
            }
            for j in 0...dataMenu[i].child!.count - 1{
                dataMenu[i].child![j].index = index
                index += 1
                if dataMenu[i].child![j].child!.isEmpty   {
                   continue
                } else if !dataMenu[i].child![j].open  {
                    for t  in 0...dataMenu[i].child![j].child!.count-1{
                        dataMenu[i].child![j].child![t].index = nil
                    }
                } else {
                    for m in 0...dataMenu[i].child![j].child!.count - 1{
                        dataMenu[i].child![j].child![m].index = index
                        index += 1
                        
                    }
                }
               
            }
        }
        
    }
    func getDataVBChuaXuLy() -> [MenuChildData]{
        var result:[MenuChildData] = []
        for i in 1...5{
            let t = MenuChildData(title: "van ban \(i)")
            result.append(t)
        }
        return result
    }
    func getDataChildLichCongtac() -> [MenuParentData]{
        var result: [MenuParentData] = []
        result.append(MenuParentData(title: "Văn bản chưa xử lý", open: false, child: []))
        result.append(MenuParentData(title: "Văn bản dự thảo chờ phê duyệt", open: false, child: []))
        return result
    }
    func getDataChildVBDieuhanh() -> [MenuParentData]{
        var result: [MenuParentData] = []
        result.append(MenuParentData(title: "Văn bản chưa xử lý", open: false, child: getDataVBChuaXuLy()))
        result.append(MenuParentData(title: "Văn bản dự thảo chờ phê duyệt", open: false, child: []))
        return result
    }
    func getDataChildNhiemVuCP() -> [MenuParentData]{
        return []
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataMenu[section].open {
            setIndexData()
            var count = 1
            count +=  dataMenu[section].child!.count
            for parent in dataMenu[section].child! {
                if(parent.open)
                {
//                    print(parent.title)
                    count += parent.child!.count}
                }
//            print(count)
            return count
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            switch indexPath.section{
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Root", for: indexPath) as! Root
                    cell.tittle.text = dataMenu[0].title
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Root", for: indexPath) as! Root
                    cell.tittle.text = dataMenu[1].title
                    return cell
                default:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Root", for: indexPath) as! Root
                    cell.tittle.text = dataMenu[2].title
                    return cell
            }
        } else {
                for i in 0...dataMenu.count - 1{
                    for parent in dataMenu[i].child! {
                        if indexPath.section == i , indexPath.row  == parent.index{
                            let cell = tableView.dequeueReusableCell(withIdentifier: "Parent", for: indexPath) as! Parent
                            cell.tittle.text = parent.title
                            return cell
                        }
                        for child in parent.child!{
                            if indexPath.section == i , indexPath.row  == child.index{
                                let cell = tableView.dequeueReusableCell(withIdentifier: "Child", for: indexPath) as! Child
                                cell.tittle.text = child.title
                                return cell
                            }
                        }
                    }
                }
                return UITableViewCell()
            }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            dataMenu[indexPath.section].open = !dataMenu[indexPath.section].open
        } else {
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath)!
            if (currentCell is Parent){
                for i in 0...dataMenu[indexPath.section].child!.count - 1{
                    if dataMenu[indexPath.section].child![i].index! == indexPath.row{
                        dataMenu[indexPath.section].child![i].open = !dataMenu[indexPath.section].child![i].open
//                        dataMenu[indexPath.section].open = !dataMenu[indexPath.section].open
                        break
                    }
                }
            }
        }
        tableView.reloadData()
    }
}
