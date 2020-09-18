note
	description : "spew application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			template_path: STRING
				-- Path to template file, from -f option

			count: INTEGER
				-- Number of spews left

			file: PLAIN_TEXT_FILE
				-- Input file

			template: TEMPLATE
				-- Ingested template


		do
			if index_of_word_option ("skip") > 0 then
				print("%N%N%N%N")
			end


			template_path := separate_word_option_value ("f")
			if template_path = Void then
				template_path := "headline"
			end
			create file.make_open_read (template_path)
			create template.make_from_file (file)

			from
				if index_of_character_option ('n') > 0 then
					count :=  separate_character_option_value ('n').to_integer_32
				else
					count := 1
				end
			until
				count = 0
			loop
				print (template.expanded_category ("MAIN"))
				if count > 1 then
					print ("%N%N")
				else
					print ("%N")
				end
				count := count - 1
			end

			junk (template)

		end




feature
	junk (t: TEMPLATE)

	local
		s: SEGMENT
		es: EXPANSION_SEGMENT
		ss: STRING_SEGMENT
	do
		create ss.make ("gobbledygook")
		s := ss
		print ("SS: ")
		print (ss.expand (t))
		print ("%N")

		create es.make ("NONSENSE")
		s := es
		print ("ES: ")
		print (s.expand (t))
		print ("%N")
	end

end -- Class {APPLICATION}
