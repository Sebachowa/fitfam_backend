module Fitfam
  class API < Grape::API
    version 'v1'
    format :json
    prefix :api


    resource :locations do

      desc 'Return all locations.'
      get do
        locations = Location.all
      end

      desc 'Create a new location'
      params do
        requires :address, type: String
        requires :latitude, type: String
        requires :longitude, type: String
        requires :directions, type: String
      end
      post do
        location = Location.create!(params)
      end

      desc 'Get all events for a certain location'
      get ':id/events' do
        location = params[:id]
        events = Event.where(location_id: location)
      end
    end

    resource :events do

      desc 'Return all events'
      get do
        events = Event.all.map do |event|
          {
            cancelled: event.is_cancelled,
            location: event.location_id,
            date: event.date
          }
        end
        {events: events}
      end

      desc 'Get details for one event.'
      params do
        requires :id, type: Integer, desc: 'Event id.'
      end
      get ':id' do
        event = Event.find(params[:id])
        event.latitude = Location.find(event.location_id).latitude
        event.longitude = Location.find(event.location_id).longitude
      end

      desc 'Create an event'
      params do
        requires :workout_type, type: String
        requires :location_id, type: Integer
        requires :max_attendance, type: Integer
      end
      post do
        Event.create!(params)
      end

      desc 'Update one event.'
      params do
        requires :id, type: Integer, desc: 'Event id.'
      end
      put ':id' do
        event = Event.find(params[:id])
        event.update(params)
      end

      desc 'Get all bookings for an event'
      params do
        requires :id, type: Integer
      end
      get ':id/bookings' do
        Booking.where(event_id: params[:id])
      end
    end

    resource :bookings do
      desc 'Create a booking'
      params do
        requires :event_id, type: Integer
        requires :user_id, type: String
      end
      post do
        Booking.create!(params)
      end

      desc 'Update a booking (check in)'
      params do
        requires :id, type: Integer
      end
      put ':id/check_in' do
        booking = Booking.find(params[:id])
        booking.update!(checked_in: true)
      end

      desc 'Cancel a booking(removes the booking entirely)'
      params do
        requires :id, type: Integer, desc: 'booking id.'
      end
      post do
        Booking.find(params[:id]).destroy!
      end
    end
  end
end
