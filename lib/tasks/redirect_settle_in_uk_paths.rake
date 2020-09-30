require "csv"

namespace :settle_in_the_uk do
  desc "Unpublish settle_in_uk content item and redirect "
  task unpublish_and_redirect: [:environment] do
    settle_in_the_uk_content_id = "32d4d2c8-2f9c-406f-96e4-65222074642a"

    puts "Unpublishing settle-in-the-uk smart-answer"
    GdsApi.publishing_api.unpublish(
      settle_in_the_uk_content_id,
      type: "redirect",
      redirects: [
        {
          path: "/settle-in-the-uk",
          type: "prefix",
          destination: "/indefinite-leave-to-remain",
        },
      ],
    )
    puts "Smart answer redirected"

    puts "--------------"

    puts "Redirecting sub-paths"

    redirects = CSV.read(Rails.root.join("lib/tasks/settle-in-uk-redirects.csv"), headers: true)
    from_paths = redirects["from"]
    to_paths = redirects["to"]

    payload = {
      "base_path" => "/settle-in-the-uk",
      "document_type" => "redirect",
      "schema_name" => "redirect",
      "publishing_app" => "smartanswers",
      "update_type" => "major",
      "redirects" => [],
    }

    from_paths.length.times do |number|
      puts "Adding redirect from #{from_paths[number]} to #{to_paths[number]}"
      redirect = {
        "path" => from_paths[number],
        "type" => "exact",
        "segments_mode" => "ignore",
        "destination" => to_paths[number],
      }

      payload["redirects"] << redirect
    end

    begin
      puts "Sending redirects to publishing-api"
      GdsApi.publishing_api.put_content(settle_in_the_uk_content_id, payload)
      GdsApi.publishing_api.publish(settle_in_the_uk_content_id, :major)
    rescue GdsApi::HTTPErrorResponse => e
      puts "An error posting to the publishing API prevented this redirect from being created"
      GovukError.notify(e, extra: payload)
    end
    puts "completed redirecting paths"
  end
end
