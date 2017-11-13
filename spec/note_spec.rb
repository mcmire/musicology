require "spec_helper"
require_relative "../lib/note"

describe Note do
  describe "#respell_with" do
    # context "given an accidental" do
      # context "given the same accidental as the Note" do
        # it "simply returns the Note" do
          # note = described_class.new(:e, :flat)

          # respelled_note = note.respell_with(accidental: :flat)

          # expect(respelled_note).to be(note)
        # end
      # end

      # context "given a sharp when the Note's accidental is a flat" do
        # it "respells the note name by one letter behind" do
          # note = described_class.new(:e, :flat)

          # respelled_note = note.respell_with(accidental: :sharp)

          # expect(respelled_note).to eq(Note.new(:d, :sharp))
        # end
      # end

      # context "given a double sharp when the Note's accidental is a flat" do
        # it "respells the note name by two letters behind" do
          # note = described_class.new(:d, :flat)

          # respelled_note = note.respell_with(accidental: :double_sharp)

          # expect(respelled_note).to eq(Note.new(:b, :double_sharp))
        # end
      # end

      # context "given a flat when the Note's accidental is a sharp" do
        # it "respells the note name by one letter ahead" do
          # note = described_class.new(:d, :sharp)

          # respelled_note = note.respell_with(accidental: :flat)

          # expect(respelled_note).to eq(Note.new(:e, :flat))
        # end
      # end

      # context "given a double flat when the Note's accidental is a sharp" do
        # it "respells the note name by two letters ahead" do
          # note = described_class.new(:d, :sharp)

          # respelled_note = note.respell_with(accidental: :double_flat)

          # expect(respelled_note).to eq(Note.new(:f, :double_flat))
        # end
      # end
    # end

    context "given a letter offset" do
      context "given an offset of 0" do
        it "simply returns the Note" do
          note = Note.new(:a, :flat)

          respelled_note = note.respell_with(letter_offset: 0)

          expect(respelled_note).to be(note)
        end
      end

      context "given an offset of -1" do
        context "when the accidental is a flat" do
          it "respells the Note a letter below" do
            note = Note.new(:a, :flat)

            respelled_note = note.respell_with(letter_offset: -1)

            expect(respelled_note).to eq(Note.new(:g, :sharp))
          end
        end

        context "when the accidental is a double flat" do
          it "respells the Note a letter below" do
            note = Note.new(:a, :double_flat)

            respelled_note = note.respell_with(letter_offset: -1)

            expect(respelled_note).to eq(Note.new(:g, :natural))
          end
        end

        context "when the note is C flat" do
          it "respells the Note as B natural" do
            note = Note.new(:c, :flat)

            respelled_note = note.respell_with(letter_offset: -1)

            expect(respelled_note).to eq(Note.new(:b, :natural))
          end
        end

        context "when the note is F flat" do
          it "respells the Note as E natural" do
            note = Note.new(:f, :flat)

            respelled_note = note.respell_with(letter_offset: -1)

            expect(respelled_note).to eq(Note.new(:e, :natural))
          end
        end

        context "when the accidental is a natural" do
          it "respells the Note a letter above" do
            note = Note.new(:g, :natural)

            respelled_note = note.respell_with(letter_offset: -1)

            expect(respelled_note).to eq(Note.new(:a, :double_flat))
          end
        end
      end

      context "given an offset of +1" do
        context "when the accidental is a sharp" do
          it "respells the Note a letter above" do
            note = Note.new(:g, :sharp)

            respelled_note = note.respell_with(letter_offset: +1)

            expect(respelled_note).to eq(Note.new(:a, :flat))
          end
        end

        context "when the accidental is a natural" do
          it "respells the Note a letter below" do
            note = Note.new(:e, :natural)

            respelled_note = note.respell_with(letter_offset: +1)

            expect(respelled_note).to eq(Note.new(:d, :double_sharp))
          end
        end

        context "when the note is E sharp" do
          it "respells the Note as F natural" do
            note = Note.new(:e, :sharp)

            respelled_note = note.respell_with(letter_offset: +1)

            expect(respelled_note).to eq(Note.new(:f, :natural))
          end
        end
      end
    end
  end
end
