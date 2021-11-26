require "rails_helper"

RSpec.describe Contest do
  
  let(:contest) {
    Contest.create
  }

  let(:user) {
    User.create(uuid: "abcd")
  }

  let(:participant_1){
    Participant.create(name: "participant_1", user: user)
  }

  let(:entry_1) {
    Entry.create(participant: participant_1, contest: contest)
  }

  let(:participant_2){
    Participant.create(name: "participant_2", user: user)
  }

  let(:entry_2) {
    Entry.create(participant: participant_2, contest: contest)
  }

  let(:participant_3){
    Participant.create(name: "participant_3", user: user)
  }

  let(:entry_3) {
    Entry.create(participant: participant_3, contest: contest)
  }

  let(:participant_4){
    Participant.create(name: "participant_4", user: user)
  }

  let(:entry_4) {
    Entry.create(participant: participant_4, contest: contest)
  }

  let(:participant_5){
    Participant.create(name: "participant_5", user: user)
  }

  let(:entry_5) {
    Entry.create(participant: participant_5, contest: contest)
  }

  let(:participant_6){
    Participant.create(name: "participant_6", user: user)
  }

  let(:entry_6) {
    Entry.create(participant: participant_6, contest: contest)
  }

  let(:participant_7){
    Participant.create(name: "participant_6", user: user)
  }

  let(:participant_8){
    Participant.create(name: "participant_6", user: user)
  }

  let(:participant_9){
    Participant.create(name: "participant_6", user: user)
  }

  let(:participant_10){
    Participant.create(name: "participant_6", user: user)
  }

  describe "rank_entries" do
    context "when tie is broken by second choice" do
      before do
        entry_1.rank(participant_1, 6)
        entry_1.rank(participant_2, 4)
        entry_1.rank(participant_3, 4)
        entry_1.rank(participant_4, 1)
        entry_1.rank(participant_5, 1)
        entry_1.rank(participant_6, 3)
        # tota: 19

        entry_2.rank(participant_1, 1)
        entry_2.rank(participant_2, 6)
        entry_2.rank(participant_3, 1)
        entry_2.rank(participant_4, 3)
        entry_2.rank(participant_5, 3)
        entry_2.rank(participant_6, 4)
        # tota: 18

        entry_3.rank(participant_1, 5)
        entry_3.rank(participant_2, 1)
        entry_3.rank(participant_3, 6)
        entry_3.rank(participant_4, 4)
        entry_3.rank(participant_5, 2)
        entry_3.rank(participant_6, 5)
        # total: 23

        entry_4.rank(participant_1, 3)
        entry_4.rank(participant_2, 2)
        entry_4.rank(participant_3, 3)
        entry_4.rank(participant_4, 6)
        entry_4.rank(participant_5, 4)
        entry_4.rank(participant_6, 2)
        # total: 20

        entry_5.rank(participant_1, 4)
        entry_5.rank(participant_2, 5)
        entry_5.rank(participant_3, 2)
        entry_5.rank(participant_4, 5)
        entry_5.rank(participant_5, 6)
        entry_5.rank(participant_6, 1)
        # total: 23

        entry_6.rank(participant_1, 2)
        entry_6.rank(participant_2, 3)
        entry_6.rank(participant_3, 5)
        entry_6.rank(participant_4, 2)
        entry_6.rank(participant_5, 5)
        entry_6.rank(participant_6, 6)
        # total: 23
      end

      context "when two are tied for first choice votes" do
        before do
          entry_1.rank(participant_6, 3)
          entry_2.rank(participant_6, 2)
          entry_3.rank(participant_6, 4)
          entry_4.rank(participant_6, 5)
          entry_5.rank(participant_6, 1)
          entry_6.rank(participant_6, 6)
      
          # entry_1: 22
          # entry_2: 20
          # entry_3: 27
          # entry_4: 25
          # entry_5: 24
          # entry_6: 29
        end

        it "picks the correct winner" do
          expect(contest.rank_entries[1]).to eq([entry_2])
          expect(contest.rank_entries[2]).to eq([entry_1])
          expect(contest.rank_entries[3]).to eq([entry_5])
          expect(contest.rank_entries[4]).to eq([entry_4])
          expect(contest.rank_entries[5]).to eq([entry_3])
          expect(contest.rank_entries[6]).to eq([entry_6])
        end
      end

      context "when two are tied across the board" do
        before do
          entry_1.rank(participant_7, 1)
          entry_2.rank(participant_7, 2)
          entry_3.rank(participant_7, 3)
          entry_4.rank(participant_7, 4)
          entry_5.rank(participant_7, 5)
          entry_6.rank(participant_7, 6)
      
          # entry_1: 20
          # entry_2: 20
          # entry_3: 26
          # entry_4: 24
          # entry_5: 28
          # entry_6: 29
        end

        it "picks returns multiple winners and ranks others correctly" do
          expect(contest.rank_entries[1]).to eq([entry_1, entry_2])
          expect(contest.rank_entries[2]).to eq([entry_4])
          expect(contest.rank_entries[3]).to eq([entry_3])
          expect(contest.rank_entries[4]).to eq([entry_5])
          expect(contest.rank_entries[5]).to eq([entry_6])
        end
      end
    end
  end
end
