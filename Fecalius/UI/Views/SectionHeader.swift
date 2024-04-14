//
//  SectionHeader.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 14/04/24.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var actionCallback: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .fontWeight(.semibold)
                .textCase(nil)
                .presentationBackground(.ultraThickMaterial)
            
            Spacer()
            
            if let actionTitle, (actionCallback != nil)  {
                Button(action: actionCallback!, label: {
                    Text(actionTitle)
                        .font(.body)
                        .textCase(nil)
                        .foregroundStyle(.link)
                })
            }
            
        }
        .listRowInsets(EdgeInsets())
        .padding(.bottom, 8)
    }
}

#Preview {
    SectionHeader(title: "Header")
}
