require 'actions/action'
require 'utils/proxy_manager'
require 'rmagick'

module MiMOWheel
    class PdfTools < Action
        def check_and_fire(args)
            if args.include?('2img')
                pdf2img
            end
            
        end

        def pdf2img
            if check_env
                pdfs=Dir.glob(File.join(Dir.pwd, "**/*.pdf"))
                target_path= initial_target_path
                total_count=pdfs.length
                current=0
                pdfs.each { |pdf|
                    current += 1
                    filename = File.basename(pdf, '.pdf')
                    info("start to convert #{current}/#{total_count}, name: #{filename}")

                    pdf_image = Magick::ImageList.new(pdf) { |op|
                        op.density = "200"
                        op.quality = 50
                        op.format = "jpg"
                    }
                    # pdf_image.quantize(256)
                    pdf_image.each_with_index do |page, index|
                        info("current page index #{index}...")
                        page.write("#{target_path}/#{filename}_#{index}.jpg")
                    end
                }
            else
                info('env initialize fail')
            end
        end

        def initial_target_path
            curr_path= Dir.pwd
            target_path=curr_path+'/tmp'
            Dir.mkdir(target_path) unless File.exists?(target_path)
            target_path
        end
        def check_env
            res = `brew list | grep imagemagick |  wc -l`
            if res.strip == '0'
                check_and_set_proxy
                system("brew install imagemagick")
            end
            res = `brew list | grep imagemagick |  wc -l`
            unset_proxy
            res.strip != '0'
        end
    end
end