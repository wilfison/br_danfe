require "spec_helper"

describe BrDanfe::Danfe do
  let(:output_pdf) { "#{base_dir}output.pdf" }

  context "when xml's version is v2.00" do
    let(:base_dir) { "./spec/fixtures/v2.00/"}

    describe "#render_pdf" do
      it "renders a basic NF-e with namespace" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_ns.xml"))

        expected = IO.binread("#{base_dir}nfe_with_ns.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end

      it "renders another basic NF-e without namespace" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_without_ns.xml"))

        expected = IO.binread("#{base_dir}nfe_without_ns.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end

      it "renders a NF-e having FCI in its items" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_fci.xml"))

        expected = IO.binread("#{base_dir}nfe_with_fci.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end

      it "renders a Simples Nacional NF-e using CSOSN" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_simples_nacional.xml"))

        expected = IO.binread("#{base_dir}nfe_simples_nacional.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end

      it "renders a NF-e with extra volumes" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_extra_volumes.xml"))

        expected = IO.binread("#{base_dir}nfe_with_extra_volumes.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end
    end

    describe "#save_pdf" do
      before { File.delete(output_pdf) if File.exist?(output_pdf) }

      it "renders a basic NF-e with namespace" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_ns.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_with_ns.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end

      it "renders another basic NF-e without namespace" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_without_ns.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_without_ns.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end

      it "renders a NF-e having FCI in its items" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_fci.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_with_fci.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end

      it "renders a Simples Nacional NF-e using CSOSN" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_simples_nacional.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_simples_nacional.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end

      it "renders a NF-e with extra volumes" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_with_extra_volumes.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_with_extra_volumes.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end
    end
  end

  context "when xml's version is v3.10" do
    let(:base_dir) { "./spec/fixtures/v3.10/"}

    describe "#render_pdf" do
      it "renders a Simples Nacional NF-e using CSOSN" do
        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_simples_nacional.xml"))

        expected = IO.binread("#{base_dir}nfe_simples_nacional.xml.fixture.pdf")

        expect(danfe.render_pdf).to eq expected
      end
    end

    describe "#save_pdf" do
      before { File.delete(output_pdf) if File.exist?(output_pdf) }

      it "renders a Simples Nacional NF-e using CSOSN" do
        expect(File.exist?(output_pdf)).to be_falsey

        danfe = BrDanfe::Danfe.new(File.read("#{base_dir}nfe_simples_nacional.xml"))
        danfe.save_pdf output_pdf

        expect("#{base_dir}nfe_simples_nacional.xml.fixture.pdf").to be_same_file_as(output_pdf)
      end
    end
  end
end