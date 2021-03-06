module DataImport
  class Definition
    class Simple < Definition

      include Lookup

      attr_accessor :target_table_name
      attr_accessor :reader, :writer
      attr_accessor :after_blocks, :after_row_blocks
      attr_accessor :row_validation_blocks

      def initialize(name, source_database, target_database)
        super
        @mappings = []
        @mode = :insert
        @after_blocks = []
        @after_row_blocks = []
        @row_validation_blocks = []
      end

      def mappings
        @mappings.to_enum
      end

      def add_mapping(mapping)
        @mappings << mapping
      end

      def run(context)
        Importer.new(context, self).run
      end

      def total_steps_required
        reader.count
      end
    end
  end
end
