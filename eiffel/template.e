note
	description: "Summary description for {TEMPLATE}."
	system: "Part of the Pi-Coral product suite."
	source: "Pi-Coral, Inc."
	license: "Proprietary"
	copyright: "Copyright (c) 2012-2013 Pi-Coral, Inc.  All Rights Reserved"
	date: "See comments at bottom of class."
	revision: "See comments at bottom of class."
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

class
	TEMPLATE

create
	make,
	make_from_file

--|========================================================================
feature {NONE} -- Members
--|========================================================================

	categories: HASH_TABLE [CATEGORY, STRING]

--|========================================================================
feature {NONE} -- Creation and initialization
--|========================================================================

	make
		local
			bang : CATEGORY
				-- For constructing the "!" newline category

		do
			create categories.make (1)
			create bang.make_from_string ("!")
			bang.add_item ("%N")
			put (bang)
		end


	make_from_file (file:PLAIN_TEXT_FILE)
		-- Construct a template from a file
		require
			usable_file: file /= Void
			open_for_read: file.is_open_read

		local
			line: STRING
				-- Line in the input we're working with

			comment_index: INTEGER_32
				-- Where we found a comment in a line, if any

			category: CATEGORY
				-- The category we're working on

		do

			make

			from file.start
			until file.end_of_file
			loop
				file.read_line
				create line.make_from_string (file.last_string)

				comment_index := line.substring_index ("\*", 1)
				if comment_index > 0 then
					line.keep_head (comment_index - 1)
				end

				line.left_adjust
				line.right_adjust

				if line.starts_with ("%%") then
					line.remove (1)
						-- The leading '%' is not part of the name.
					create category.make_from_string(line)
					categories.force (category, category.name)

				elseif not line.is_empty and category /= Void then
					category.add_item (line)
				end

			end -- loop

		end


--|========================================================================
feature -- Status
--|========================================================================

	has (c: STRING) : BOOLEAN
		-- True if a the named category exists
		do
			Result := categories.has (c)
		end

--|========================================================================
feature -- Status setting
--|========================================================================

--|========================================================================
feature -- Access
--|========================================================================

	expanded_category_modified (c: STRING; m: CHARACTER) : STRING
		-- Expand a category with modifier m, which may be ' ' for none.
	do
		if has(c) then
			Result := categories.item (c).random_item (Current, m)
		else
			Result := "[NO EXPANSION FOR " + c + "]"
		end
	end

	expanded_category (c: STRING) : STRING
		-- Expand a category with no modifier
	do
		Result := expanded_category_modified (c, ' ')
	end

--|========================================================================
feature -- Comparison
--|========================================================================

--|========================================================================
feature -- Element change
--|========================================================================

	put (c: CATEGORY)
		-- Add or replace a category
	require
		valid_category: c /= Void
	do
		categories.force (c, c.name)
	ensure
		was_added: categories.count = old categories.count + 1
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

end -- class {TEMPLATE}
