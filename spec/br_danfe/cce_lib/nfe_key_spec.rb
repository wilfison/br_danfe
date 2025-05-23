require 'spec_helper'

describe BrDanfe::CceLib::NfeKey do
  let(:base_dir) { './spec/fixtures/cce/lib/' }
  let(:output_pdf) { "#{base_dir}output.pdf" }

  let(:pdf) { BrDanfe::CceLib::Document.new }
  let(:xml) { File.read('./spec/fixtures/cce/v1.00/cce.xml') }

  subject { described_class.new(pdf, xml) }

  describe '#render' do
    before do
      subject.render
      FileUtils.rm_f(output_pdf)
    end

    it 'renders header to the pdf' do
      expect(File.exist?(output_pdf)).to be_falsey

      pdf.render_file output_pdf

      expect("#{base_dir}nfe_key#render.pdf").to have_same_content_of file: output_pdf
    end
  end
end
