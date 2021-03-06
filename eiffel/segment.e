note
	description: "Abstract class for Spew text segments."
	system: "Part of the Pi-Coral product suite."
	source: "Pi-Coral, Inc."
	license: "Proprietary"
	copyright: "Copyright (c) 2012-2013 Pi-Coral, Inc.  All Rights Reserved"
	date: "See comments at bottom of class."
	revision: "See comments at bottom of class."
	howto: "See comments at bottom of class."
	history: "See comments at bottom of class."

deferred class SEGMENT


--|========================================================================
feature {NONE} -- Creation and initialization
--|========================================================================

	make (s: STRING)
	require
		valid_string: s /= Void
	deferred
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
		-- Expand a text segment using modifier m and TEMPLATE t
	require
			valid_template: t /= Void
	deferred
	end

	expand_modified (t: TEMPLATE; m: CHARACTER) : STRING
		-- Expand a text segment using modifier m and TEMPLATE t
	require
		valid_template: t /= Void
		valid_modifier: m /= Void
	deferred
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

end -- class {SEGMENT}
