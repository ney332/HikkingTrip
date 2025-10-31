//
//  MapRouteView.swift
//  HikingTrip2
//
//  Created by Assistant on 10/10/25.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapRouteView: View {
    let route: MKRoute
    let origin: CLLocationCoordinate2D
    let destination: CLLocationCoordinate2D
    let trails: [Trail]

    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        Map(position: $position) {
            // Polyline da rota
            MapPolyline(route.polyline)
                .stroke(.blue, lineWidth: 4)

            // Pins de origem e destino
            MapAnnotation(coordinate: origin) {
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                    Text("Origem")
                        .font(.caption2)
                        .padding(2)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }

            MapAnnotation(coordinate: destination) {
                VStack(spacing: 4) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                    Text("Destino")
                        .font(.caption2)
                        .padding(2)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                }
            }

            // Pins das trilhas sugeridas
            ForEach(trails) { trail in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: trail.latitude, longitude: trail.longitude)) {
                    VStack(spacing: 4) {
                        Image(systemName: "figure.hiking")
                            .font(.headline)
                            .foregroundStyle(.orange)
                        Text(trail.name)
                            .font(.caption2)
                            .lineLimit(1)
                            .padding(2)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                    }
                }
            }
        }
        .onAppear {
            // Ajusta a câmera para enquadrar a rota
            let rect = route.polyline.boundingMapRect
            position = .rect(rect)
        }
        .navigationTitle("Rota do Roteiro")
        .navigationBarTitleDisplayMode(.inline)
    }
}
