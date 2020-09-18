note
	description: "A {SEGMENT} which selects values based on a modifier."
	system: "Part of the Pi-Coral product suite."
	source: "Pi-Coral, Inc."
	license: "Proprietary"
	copyright: "Copyright (c) 2012-2013 Pi-Coral, Inc.  All Rights Reserved"
	date: "See comments at bottom of class."
	revision: "See comments at bottom of class."
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

class SELECT_SEGMENT

inherit
	SEGMENT

--|========================================================================
feature {NONE} -- Members
--|========================================================================

	choices: ARRAY [STRING]
		-- List of numbered expansions

--|========================================================================
feature {NONE} -- Creation and initialization
--|========================================================================

	make (s: STRING)
		-- Make an expansion segment from a string, splitting on the
		-- pipe ('%V') symbol
	do
		choices := s.split('|')
	end

--|========================================================================
feature -- Status
--|========================================================================

--|========================================================================
feature -- Status setting
--|========================================================================

--|========================================================================
feature -- Access
--|========================================================================

	expand (t: TEMPLATE) : STRING
		-- Expand segment using TEMPLATE t
	do
		-- TODO: Flesh this out.
		if t.has(category) then
			Result := t.expanded_category (category)
		else
			Result := "[NO EXPANSION FOR " + category + "]"
		end
	end


	expand_modified (t: TEMPLATE; m: CHARACTER) : STRING
		-- Expand segment using modifier m and TEMPLATE t
	do
		-- TODO: Flesh this out.
		if t.has(category) then
			Result := t.expanded_category_modified (category, m)
		else
			Result := "[NO EXPANSION FOR " + category + "]"
		end
	end

--|========================================================================
feature -- Comparison
--|========================================================================

--|========================================================================
feature -- Element change
--|========================================================================

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

end -- class {SELECT_SEGMENT}
