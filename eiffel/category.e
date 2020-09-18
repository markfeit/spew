note
	description: "Summary description for {CATEGORY}."
	system: "Part of the Pi-Coral product suite."
	source: "Pi-Coral, Inc."
	license: "Proprietary"
	copyright: "Copyright (c) 2012-2013 Pi-Coral, Inc.  All Rights Reserved"
	date: "See comments at bottom of class."
	revision: "See comments at bottom of class."
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

class
	CATEGORY

inherit
	ANY
		redefine
			out
		end

create
	make,
	make_with_modifiers,
	make_from_string

--|========================================================================
feature -- Public Members
--|========================================================================

	name: STRING
		-- Name of category

--|========================================================================
feature {NONE} -- Private Members
--|========================================================================

	modifiers: HASH_TABLE [NATURAL, CHARACTER]
		-- List of modifies from FOO{as} format

	items: ARRAY [STRING]
		-- Things to pick from
		-- TODO: Make this an ARRAY [ITEM]

	rng: RANDOM
		-- Random number generator

--|========================================================================
feature {NONE} -- Creation and initialization
--|========================================================================

	make (new_name: STRING)
		-- Construct an empty category
	require
		usable_name: new_name /= Void
		sensible_name: not new_name.is_empty
	do
		name := new_name
		create modifiers.make(0)
		create items.make_empty
		create rng.make
			-- TODO: Need to seed this.
	end

	make_with_modifiers (new_name: STRING; new_modifiers: ARRAY [CHARACTER])
		-- Construct from a name and an array of modifier characters
	require
		usable_name: new_name /= Void
		sensible_name: not new_name.is_empty
	local
		modifier: INTEGER_32
			-- Index into list of modifiers
	do
		make (new_name)
		from
			modifier := 1
		until
			modifier > new_modifiers.count
		loop
			modifiers.put (modifier.as_natural_32, new_modifiers.at (modifier))
			modifier := modifier + 1
		end
	end


	make_from_string (new_name:STRING)
		-- Construct a new category from a category string of the format NAME{modifiers}
	require
		usable_name: new_name /= Void
		sensible_name: not new_name.is_empty
	local
		new_modifiers: ARRAY [CHARACTER]
			-- Modifiers found in string, if any.
		last_open_brace: INTEGER
			-- Where we found the start of the modifier list
		modifier_position: INTEGER
			-- Where in the list of modifiers we are
		modifier_index: INTEGER
			-- Index into the modifier substring, relative to start
	do
		-- TODO: Does new_name need to be cloned before we alter it?

		create new_modifiers.make_empty

		if new_name.ends_with ("}") then

			-- Extract modifiers from {abc} at the end of the string
			last_open_brace := new_name.last_index_of ('{', new_name.count - 1)
			if last_open_brace > 0  then
				new_name.remove_tail (1)
				new_modifiers.grow (new_name.count - last_open_brace)
				from
					modifier_index := 1
					modifier_position := last_open_brace + 1
				until
					modifier_position > new_name.count
				loop
					new_modifiers.put(new_name.at (modifier_position), modifier_index)
					modifier_index := modifier_index + 1
					modifier_position := modifier_position + 1
				end
				new_name.keep_head (last_open_brace - 1)
				make_with_modifiers (new_name, new_modifiers)
			end

		else

			make(new_name)

		end

	end

--|========================================================================
feature -- Status
--|========================================================================

	count : INTEGER
		do
			Result := items.count
		end

--|========================================================================
feature -- Status setting
--|========================================================================

--|========================================================================
feature -- Access
--|========================================================================

	random_item (t: TEMPLATE; m: CHARACTER) : STRING
		-- Return a random item or the empty string if the category is empty,
		-- applying modifier m if not void
		do
			if items.count > 0 then
				rng.forth
				Result := items [rng.item \\ items.count + 1]
			else
				Result := ""
			end
		ensure
			valid_result: Result /= void
		end

--|========================================================================
feature -- Comparison
--|========================================================================

--|========================================================================
feature -- Element change
--|========================================================================

	add_item(s:STRING)
	require
		valid_string: s /= Void
		meaningful_string: s.count > 0
	do
		items.force (s, items.count + 1)
	ensure
		item_added: items.count = old items.count + 1
	end

--|========================================================================
feature -- Element removal
--|========================================================================

--|========================================================================
feature -- Persistence
--|========================================================================

--|========================================================================
feature -- Conversion
--|========================================================================

	out: STRING
	local
		modifier: INTEGER
			-- Modifier number
	do
		Result := name

		if modifiers.count > 0 then
			Result := Result + "{"
			from
				modifier := 1
			until
				modifier > modifiers.count
			loop
				-- TODO: Find a way to get the key from the value
				Result := Result + "x"
				modifier := modifier + 1
			end
			Result := Result + "}"
		end
	end

--|========================================================================
feature -- Validation
--|========================================================================

--|========================================================================
feature {NONE} -- Implementation
--|========================================================================

--|========================================================================
feature -- Type anchors
--|========================================================================

--|========================================================================
feature {NONE} -- Constants
--|========================================================================

	--|--------------------------------------------------------------
invariant
	invariant_clause: True -- Your invariant here

--|----------------------------------------------------------------------
--| History
--|
--| 001 01-Sep-2013
--|     Created original module (for Eiffel 7.2, void-safe)
--|----------------------------------------------------------------------
--| How-to
--|
--|----------------------------------------------------------------------

end -- class {CATEGORY}
