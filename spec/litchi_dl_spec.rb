require "spec_helper"
require "mp3info"

describe LizhiFm::Downloader do
  it 'can download mp3 files' do
    downloader = LizhiFm::Downloader.new(File.join('spec', 'test-data', 'download.yaml'))
    result = downloader.start

    expect(result[:failures]).to be_empty

    result[:successes].each do |_url, file_name|
      Mp3Info.open(file_name) do |mp3|
        expect(mp3.tag.title).to be_truthy
        expect(mp3.tag.artist).to be_truthy
        expect(mp3.tag.album).to be_truthy
      end
    end

  end
end
