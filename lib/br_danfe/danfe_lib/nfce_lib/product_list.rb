module BrDanfe
  module DanfeLib
    module NfceLib
      class ProductList
        def initialize(pdf, xml)
          @pdf = pdf
          @xml = xml
        end

        def render
          @pdf.draw_horizontal_line

          render_headers(headers)
          render_products
        end

        private

        def render_headers(headers)
          2.times { @pdf.render_blank_line }
          cursor = @pdf.cursor
          headers.each_with_index do |header, index|
            cursor -= 10 if index == 1
            @pdf.bounding_box [columns[index][:position], cursor], width: columns[index][:width], height: 0.3.cm do
              @pdf.text header[:content], header[:options]
            end
          end
        end

        def headers
          [
            header_column('CÓDIGO - DESCRIÇÃO', :left),
            header_column('QTD', :left),
            header_column('UN', :center),
            header_column('VL UNIT', :right),
            header_column('TOTAL', :right)
          ]
        end

        def header_column(title, align)
          { content: title, options: { align: align, size: 8, style: :bold } }
        end

        def columns
          [
            { width: 7.cm, position: 0 },
            { width: 1.9.cm, position: 0.cm },
            { width: 1.5.cm, position: 1.9.cm },
            { width: 1.6.cm, position: 3.4.cm },
            { width: 2.cm, position: 5.cm }
          ]
        end

        def render_products
          @pdf.render_blank_line
          products.each do |product|
            cursor = @pdf.cursor

            product.each_with_index do |cell, index|
              cursor -= 10 if index == 1
              @pdf.bounding_box [columns[index][:position], cursor], width: columns[index][:width], height: 0.3.cm do
                options = cell[:options].merge(overflow: :truncate)
                @pdf.text_box cell[:content], options
              end
            end
          end
        end

        def products
          @xml.collect('xmlns', 'det') { |det| product(det) }
        end

        def product(det)
          [
            cell_text("#{det.css('prod/cProd').text} - #{det.css('prod/xProd').text}"),
            cell_text(BrDanfe::Helper.numerify(det.css('prod/qCom').text), align: :left),
            cell_text(det.css('prod/uCom').text, align: :center),
            cell_number(BrDanfe::Helper.numerify(det.css('prod/vUnCom').text)),
            cell_number(BrDanfe::Helper.numerify(det.css('prod/vProd').text))
          ]
        end

        def cell_text(text, options = {})
          cell = { content: text, options: { border_width: 0, size: 8 } }
          cell[:options].merge!(options)
          cell
        end

        def cell_number(text)
          cell_text(text, align: :right)
        end
      end
    end
  end
end
