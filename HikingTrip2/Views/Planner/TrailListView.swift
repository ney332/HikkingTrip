//
//  TrailListView.swift
//  telaApi
//
//  Created by Lorran Silva on 31/10/25.
//
import SwiftUI

struct TrailListView: View {
    @State private var trails: [Trail] = []
    private let service = TrailService()

    var body: some View {
        NavigationView {
            List(trails) { trail in
                NavigationLink(destination: TrailDetailView(trail: trail)) {
                    TrailCardView(trail: trail)
                }
            }
            .navigationTitle("🌍 Trilhas e Roteiros")
            .onAppear {
                service.fetchTrails { self.trails = $0 }
            }
        }
    }
}

struct TrailCardView: View {
    let trail: Trail

    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: trail.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 80)
                    .cornerRadius(10)
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(trail.name)
                    .font(.headline)
                Text("\(trail.country) • \(trail.difficulty)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.caption)
                    Text(String(format: "%.1f", trail.rating))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview{
    TrailListView()
}