//
//  PosterImageView.swift
//  AlticeTakeHomeAssignment
//
//  Created by Adam Martinez on 1/15/26.
//

import Foundation
import SwiftUI

struct PosterImageView: View {
    let posterPath: String?
    var width: CGFloat = 70
    var height: CGFloat = 105
    var cornerRadius: CGFloat = 10

    var body: some View {
        Group {
            if let posterPath,
               let url = URL(string: "\(Constants.imageBaseURL)\(posterPath)") {

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: width, height: height)

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height)
                            .clipped()
                            .cornerRadius(cornerRadius)

                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: width, height: height)

                    @unknown default:
                        EmptyView()
                    }
                }

            } else {
                Image(systemName: "photo")
                    .frame(width: width, height: height)
            }
        }
    }
}
