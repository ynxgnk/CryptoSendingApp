//
//  ChartViewController.swift
//  project
//
//  Created by Nazar Kopeika on 07.07.2023.
//

import UIKit
import Charts

class ChartViewController: UIViewController {
    
    let viewModel: CoinDetailsViewModel
    private let lineChartView: LineChartView
    
    init(viewModel: CoinDetailsViewModel) {
        self.viewModel = viewModel
        self.lineChartView = LineChartView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        configureChart()
    }
    
    private func setupViews() {
        lineChartView.frame = view.bounds
        lineChartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(lineChartView)
    }
    
    private func configureChart() {
        // Configure X-axis
        let xValues = viewModel.xAxisValues.map { $0.timeIntervalSince1970 }
        let xaxis = lineChartView.xAxis
        xaxis.valueFormatter = DefaultAxisValueFormatter(block: { value, _ in
            let dateIndex = Int(value)
            if dateIndex >= 0 && dateIndex < xValues.count {
                let date = Date(timeIntervalSince1970: xValues[dateIndex])
                return date.asShortDateString()
            }
            return ""
        })
        
        // Configure Y-axis
        let yValues = viewModel.yAxisValues.map { ChartDataEntry(x: 0, y: $0) }
        let yaxis = lineChartView.leftAxis
        yaxis.valueFormatter = DefaultAxisValueFormatter(block: { value, _ in
            return Double(value).formattedWithAbbreviations()
        })
        
        // Create chart data
        let dataSet = LineChartDataSet(entries: yValues, label: nil)
        dataSet.lineWidth = 2.0
        dataSet.colors = [viewModel.chartLineColor]
        dataSet.circleRadius = 4.0
        dataSet.circleHoleRadius = 2.0
        dataSet.circleColors = [viewModel.chartLineColor]
        dataSet.drawCircleHoleEnabled = true
        dataSet.drawValuesEnabled = false
        let data = LineChartData(dataSet: dataSet)
        
        // Set chart data
        lineChartView.data = data
        
        // Set chart styling
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.animate(xAxisDuration: 0.5)
    }
}
