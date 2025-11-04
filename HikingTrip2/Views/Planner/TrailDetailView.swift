//
//  TrailDetailView.swift
//  telaApi
//
//  Created by Lorran Silva on 31/10/25.
//

import SwiftUI
import MapKit

struct TrailDetailView: View {
    let trail: Trail

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: trail.image)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }

            VStack(alignment: .leading, spacing: 12) {
                Text(trail.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("\(trail.location), \(trail.country)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Label("\(trail.difficulty)", systemImage: "flame.fill")
                    Label("\(trail.length_km, specifier: "%.1f") km", systemImage: "ruler")
                    Label("\(trail.duration)", systemImage: "clock")
                }
                .font(.caption)
                .foregroundColor(.secondary)

                Divider()

                Text("⭐️ \(trail.rating, specifier: "%.1f") / 5.0")
                    .font(.headline)

                Text(trail.description)
                    .font(.body)
                    .padding(.top, 4)

                // Mapa
                Map(
                    coordinateRegion: .constant(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: trail.coordinates.lat,
                                longitude: trail.coordinates.lon
                            ),
                            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
                        )
                    ),
                    annotationItems: [trail]
                ) { trail in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(
                            latitude: trail.coordinates.lat,
                            longitude: trail.coordinates.lon
                        ),
                        tint: .green
                    )
                }
                .frame(height: 200)
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(trail.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

