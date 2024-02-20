//
//  SheetHeader.swift
//  Fecalius
//
//  Created by Thiago Lütz Dias on 19/02/24.
//

import SwiftUI

struct SheetHeader<Content>: View where Content : View{
    let title: String
    let subtitle: String?
    @ViewBuilder
    var actions: () -> Content
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            
            Spacer()
            
            actions()
            
        }
        .padding()
    }
}

#Preview {
    SheetHeader(title: "title", subtitle: nil) {
        Button {
            print("click")
        } label: {
            Image(systemName: "plus")
                .resizable()
                .padding(4)
                .frame(width: 30, height: 30)
        }
    }
}
