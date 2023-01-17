require_relative "room"

class Hotel

    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |room_name, capacity|
            @rooms[room_name] = Room.new(capacity)
        end
    end

    def name
        @name.split.map(&:capitalize).join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        @rooms.has_key?(room_name)
    end

    def check_in(person, room_name)
        unless self.room_exists?(room_name)
            print "sorry, room does not exist"
            return
        end

        exists = @rooms[room_name].add_occupant(person)
        if exists
            print "check in successful"
        else
            print "sorry, room is full"
        end
    end

    def has_vacancy?
        rooms.values.any? do |room|
            if !room.full?
                return true
            end
        end
        false
    end
    
    def list_rooms
        @rooms.each do |name, room| 
            puts "#{name}: #{room.available_space}"
        end
    end

end
