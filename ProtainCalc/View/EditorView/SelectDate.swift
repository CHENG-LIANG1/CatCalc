//
//  SelectDate.swift
//  ProtainCalc
//
//  Created by Cheng Liang(Louis) on 2022/12/11.
//

import SwiftUI

struct SelectDate: View {
    @Binding var date:Date

    var body: some View {
        DatePicker("Date", selection: $date, displayedComponents: .date)
            .datePickerStyle(.graphical)
        
    }
}

//struct SelectDate_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectDate()
//    }
//}
