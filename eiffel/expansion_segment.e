note
	description: "Summary description for {EXPANSION_SEGMENT}."
	system: "Part of the Pi-Coral product suite."
	source: "Pi-Coral, Inc."
	license: "Proprietary"
	copyright: "Copyright (c) 2012-2013 Pi-Coral, Inc.  All Rights Reserved"
	date: "See comments at bottom of class."
	revision: "See comments at bottom of class."
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

class EXPANSION_SEGMENT

inherit
	SEGMENT

create
	make

--|========================================================================
feature {NONE} -- Members
--|========================================================================

	category: STRING
		-- Name of category to expand

	modifier: CHARACTER
		-- Modifier to use, ' ' for default


--|========================================================================
feature {NONE} -- Creation and initialization
--|========================================================================

	make (c: STRING)
		-- Make an expansion segment that calls category C, with a possible
		-- modifier in the form of CATEGORY/m where m is the modifier.
	local
		slash_position: INTEGER
			-- Where we'd find a slash if there is one.
	do
		slash_position := c.count - 1
		if c.at (slash_position) = '/' then
			modifier := c.at (c.count)
			c.keep_head (slash_position - 1)
		end
		category := c
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

--|----------------------------------------------------------------------
--| History
--|
--| 001 01-Sep-2013
--|     Created original module (for Eiffel 7.2, void-safe)
--|----------------------------------------------------------------------
--| How-to
--|
--|----------------------------------------------------------------------

end -- class {EXPANSION_SEGMENT}
