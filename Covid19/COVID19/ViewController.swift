//
//  ViewController.swift
//  COVID19
//
//  Created by jiyun moon on 2022/01/13.
//

import UIKit
import Charts
import Alamofire


//    @IBOutlet weak var bar_totalCase: UILabel!
//    @IBOutlet weak var bar_newCase: UILabel!


class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchCovidOverview(completionHandler: { [weak self] result in
      
                      guard let self = self else { return }
                      switch result {
                      case let .success(result):
          //                debugPrint("success \(result)")
                          self.configureStackView(koreaCovidOverView: result.korea)
                          let covidOverviewList = self.makeCovidOverviewList(cityCovidOverview: result)
                          
                          
                          self.configurBarChartView(covidOverviewList: covidOverviewList)
                          self.configureChartView(covidOverviewList: covidOverviewList)
                          
                          //MARK: - scroll view 
                          self.scrollView.delegate = self
                          self.view.bringSubviewToFront(self.pageControl)
                          
                          let subviewlist = [self.barChartView, self.pieChartView]
                          
                          for i in 0..<2{
                              guard let view = subviewlist[i] else {return}
                              let xPos = self.view.frame.width * CGFloat(i)
                              view.frame = CGRect(x: xPos, y: 0, width: self.scrollView.bounds.width, height: self.scrollView.bounds.height)
                              self.scrollView.addSubview(view)
                              self.scrollView.contentSize.width = view.frame.width * CGFloat(i+1)
                          }
                                
                          self.setPageControl()
      
      
      
                      case let .failure(error):
                          debugPrint("error ?????? -- \(error)")
                      }
      
                  })
    }
    
   //MARK: - page control ??????
    private func setPageControl() {
        pageControl.numberOfPages = 2
    }
    
    private func setPageControlSelectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    //MARK: - scroll view ??????
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        setPageControlSelectedPage(currentPage: Int(round(value)))
    }
    
    
    //MARK: - model List ??????
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview] {
        return [
//            cityCovidOverview.korea,
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.gangwon,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.jeonbuk,
            cityCovidOverview.jeonnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    
    //MARK: - Bar Chart ??????
    func configurBarChartView(covidOverviewList: [CovidOverview]) {
        let entries = covidOverviewList.enumerated().compactMap{ [weak self] overview -> BarChartDataEntry? in
            guard let self = self else { return nil }
            return BarChartDataEntry(x: Double(overview.offset), y: self.removeFormatString(string: overview.element.newCase))
            }
        
        let x_labels = covidOverviewList.compactMap{ [weak self] overview ->String? in
            guard let self = self else { return nil }
            return overview.countryName
        }
        
        let dataSet = BarChartDataSet(entries: entries, label: "?????? ????????? ?????? ??????")
        dataSet.colors = [.systemRed]
        dataSet.highlightEnabled = false
        dataSet.valueFont = .systemFont(ofSize: 12)
        BarChartData(dataSet: dataSet).barWidth = Double(0.01)
        
        self.barChartView.data = BarChartData(dataSet: dataSet)
        
        // ?????? ??? zoom
        barChartView.doubleTapToZoomEnabled = false
        
        // x label ?????? ??? ?????????
        barChartView.xAxis.labelFont = .systemFont(ofSize: 10)
        barChartView.xAxis.labelRotationAngle = -20
        barChartView.xAxis.labelPosition = .bottomInside
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_labels)
        // ?????? ????????? ???????????????
        barChartView.xAxis.setLabelCount(x_labels.count, force: false)
        // ????????? ??? ?????????
        barChartView.rightAxis.enabled = false
        
        // ????????? ?????? ??? x, y??? ??????
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        barChartView.drawBordersEnabled = false
        // ???????????????
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        barChartView.drawValueAboveBarEnabled = true
        barChartView.barData?.setValueFont(.systemFont(ofSize: 9))
        
        
        barChartView.legend.font = .systemFont(ofSize: 12)
        barChartView.backgroundColor = .systemBackground
        
        
        
    }
    
    
    //MARK: - Pie Chart ??????
    func configureChartView(covidOverviewList: [CovidOverview]) {
        self.pieChartView.delegate = self
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil}
            return PieChartDataEntry(value: self.removeFormatString(string: overview.newCase),
                                     label: overview.countryName,
                                     data: overview)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "?????? ????????? ?????? ??????")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .black
        dataSet.valueTextColor = .black
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel()+ChartColorTemplates.material()
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 100)
        
        self.pieChartView.chartDescription?.font = .systemFont(ofSize: 7)
        self.pieChartView.chartDescription?.textAlign = .justified
        
    }
    
    //MARK: - ????????? -> Double ?????????
    func removeFormatString(string: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: string)?.doubleValue ?? 0
    }
    
    //MARK: - Label ??????
    func configureStackView(koreaCovidOverView: CovidOverview) {
        self.totalCaseLabel.text = "\(koreaCovidOverView.totalCase) ???"
        self.newCaseLabel.text = "\(koreaCovidOverView.newCase) ???"
//        self.bar_totalCase.text = "\(koreaCovidOverView.totalCase) ???"
//        self.bar_newCase.text = "\(koreaCovidOverView.newCase) ???"
    }
    
    
    //MARK: - API ??????
    func fetchCovidOverview( completionHandler: @escaping (Result<CityCovidOverview, Error> ) -> Void) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey" : "your_api_key"
        ]
        
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                    
                }
            })
        }
    }

extension ViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let covidDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "CovidDetailViewController") as? CovidDetailViewController else { return }
        guard let covidOverview = entry.data as? CovidOverview else { return }
        covidDetailViewController.covidOverview = covidOverview
        self.navigationController?.pushViewController(covidDetailViewController, animated: true)
    }
}
